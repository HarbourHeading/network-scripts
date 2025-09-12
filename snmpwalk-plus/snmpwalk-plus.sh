#!/bin/bash
#
# Gets translated OID next to the raw OID and the associated value.
# Meant for services like telegraf that require raw OID,
# while also keeping human-readable names in the same line.
#
# By default, it loads ALL mibs in /usr/share/snmp/mibs
#
# Author:
# Creation: 2025-09-11

# Temporary files
NAMED_OUT="/tmp/snmp_named.out"
RAW_OUT="/tmp/snmp_raw.out"
OUTPUT="/tmp/snmp_complete.txt"
# SNMP target
SNMP_TARGET="example.com"
# SNMP security name
SEC_NAME="snmp_user"
# Authentication protocol; E.g. one of "MD5", "SHA", "SHA224", "SHA256", "SHA384", "SHA512" or "".
AUTH_PROTOCOL="SHA"
# Privacy protocol used for encrypted messages; E.g. one of "DES", "AES", "AES192", "AES192C", "AES256", "AES256C", or "".
PRIV_PROTOCOL="AES"
# MIBS path
MIB_PATH="/usr/share/snmp/mibs"

# Check SNMPv3 tokens are defined (Auth and Priv tokens)
if [ -z "$SNMP_AUTH_TOKEN" ] || [ -z "$SNMP_PRIV_TOKEN" ]; then
    echo "WARNING: SNMPv3 AUTH_TOKEN or PRIV_TOKEN is missing."
    echo "Please export the following environment variables before rerunning the script:"
    echo "export SNMP_AUTH_TOKEN='your_authentication_token'"
    echo "export SNMP_PRIV_TOKEN='your_privacy_token'"
    exit 1
fi

# Translated OIDs
snmpwalk -v3 -l authPriv -u "$SEC_NAME" -a "$AUTH_PROTOCOL" -A "$SNMP_AUTH_TOKEN" -x "$PRIV_PROTOCOL" -X "$SNMP_PRIV_TOKEN" -M "$MIB_PATH" -m ALL "$SNMP_TARGET" > "$NAMED_OUT"
# Raw OIDs
snmpwalk -v3 -l authPriv -u "$SEC_NAME" -a "$AUTH_PROTOCOL" -A "$SNMP_AUTH_TOKEN" -x "$PRIV_PROTOCOL" -X "$SNMP_PRIV_TOKEN" -On "$SNMP_TARGET" > "$RAW_OUT"

# Check that line counts match
if [ "$(wc -l < "$NAMED_OUT")" -ne "$(wc -l < "$RAW_OUT")" ]; then
    echo "SNMPwalk output mismatch. Aborting."
    exit 1
fi

# Create output file
{
    printf "%-35s | %-40s | %s\n" "Translated MIB" "Raw OID" "Value"
    printf -- "----------------------------------- | ---------------------------------------- | --------------------------\n"

    paste "$NAMED_OUT" "$RAW_OUT" | while IFS=$'\t' read -r named raw; do
        # Extract content
        mib_field=$(echo "$named" | cut -d'=' -f1 | xargs)
        raw_oid=$(echo "$raw" | cut -d'=' -f1 | xargs)
        value=$(echo "$named" | cut -d'=' -f2- | xargs)

        printf "%-35s | %-40s | %s\n" "$mib_field" "$raw_oid" "$value"
    done
} > "$OUTPUT"

rm -f "$NAMED_OUT" "$RAW_OUT"

echo "Clean SNMP output saved to $OUTPUT"
