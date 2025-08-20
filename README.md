# Network scripts

An archive of scripts I've written. Some scripts are split into their own repository, in which case they will still be listed here
with a link to the project provided in its `README.md`.

## DNAC Backup Manager

[DNAC Backup Manager](dnac-backup-retention) is a Python CLI tool to show/list or delete backups on Cisco DNA Center.
This tool can show the current backups, delete a specific backup by id or delete all backups older than a certain time (the default is 2 years).

Does not autorun itself. A cronjob or equivalent to run the script on interval is recommended.

## Log Retention

[Log Retention](log-retention) is a shell script that reads a JSON configuration file and deletes old files in specified directories,
keeping only the most recent ones based on a filename pattern. Can set paths, regexes and amount to keep.
Allows for setting multiple unique retention setups.

Does not autorun itself. A cronjob or equivalent to run the script on interval is recommended.
