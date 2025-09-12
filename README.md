# Network scripts

An archive of scripts I've written. Some scripts are split into their own repository, in which case they will still be listed here
with a link to the project provided in its `README.md`.

## DNAC Backup Manager

[DNAC Backup Manager](dnac-backup-retention) is a Python CLI tool to show/list or delete backups on Cisco DNA Center.
This tool can show the current backups, delete a specific backup by id or delete all backups older than a certain time (the default is 2 years).

Does not autorun itself. A cronjob or equivalent to run the script on interval is recommended.

## SNMPwalk Plus
Gets translated OID next to the raw OID and the associated value. Meant for services like telegraf that require raw OID,
while also keeping human-readable names on the same line. Meant to be used for initial setup or debugging.

Example output
````text
Translated MIB                      | Raw OID                                  | Value
----------------------------------- | ---------------------------------------- | --------------------------
UPS-MIB::upsBatteryStatus.0         | .1.3.6.1.2.1.33.1.2.1.0                  | INTEGER: batteryNormal(2)
UPS-MIB::upsSecondsOnBattery.0      | .1.3.6.1.2.1.33.1.2.2.0                  | INTEGER: 0 seconds
````

## Offline Git Hooks

Solution to share git hooks with a team, as `.git/hooks/` is not a version controlled file. Made with offline development environments in mind.
Supports [python](offline-git-hooks/git-hooks/python/pre-commit) and [ansible](offline-git-hooks/git-hooks/ansible/pre-commit) pre-hook linting and checking processes.

Does not utilize the [pre-commit](https://github.com/pre-commit/pre-commit) framework as that project is mostly dependent on online connectivity, as it fetches from remote repos.
We couldn't use it as we required an offline development solution. For reference, [pre-commit does support local routes](https://stackoverflow.com/a/67796237), 
but seemed like a little more work than just writing my own pre-commit script.

## Log Retention

[Log Retention](log-retention) is a shell script that reads a JSON configuration file and deletes old files in specified directories,
keeping only the most recent ones based on a filename pattern. Can set paths, regexes and amount to keep.
Allows for setting multiple unique retention setups.

Does not autorun itself. A cronjob or equivalent to run the script on interval is recommended.

