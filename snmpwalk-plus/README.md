# Full SNMPWalk

## Overview

Gets translated OID next to the raw OID and the associated value.
Meant for services like telegraf that require raw OID,
while also keeping human-readable names in the same line.

By default, it loads ALL mibs in `/usr/share/snmp/mibs`. Meant to be used in initial/debugging SNMP setup for a device.

Assumes snmpv3. Can easily be modified for another version by changing SNMPwalk command and input. Update paths inside the script and export the tokens. See instructions in [Getting Started](#getting-started).

Example output to temp file
````
Translated MIB                      | Raw OID                                  | Value
----------------------------------- | ---------------------------------------- | --------------------------
UPS-MIB::upsBatteryStatus.0         | .1.3.6.1.2.1.33.1.2.1.0                  | INTEGER: batteryNormal(2)
UPS-MIB::upsSecondsOnBattery.0      | .1.3.6.1.2.1.33.1.2.2.0                  | INTEGER: 0 seconds
UPS-MIB::upsEstimatedMinutesRemaining.0 | .1.3.6.1.2.1.33.1.2.3.0                  | INTEGER: 105 minutes
UPS-MIB::upsEstimatedChargeRemaining.0 | .1.3.6.1.2.1.33.1.2.4.0                  | INTEGER: 100 percent
````

## Getting Started

Update values in [script file](snmpwalk-plus.sh):
````shell
(...)
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
(...)
````
Then export tokens
````shell
# Environment Variables for SNMPv3
export SNMP_AUTH_TOKEN="my-auth-token"
export SNMP_PRIV_TOKEN="my-priv-token"
````