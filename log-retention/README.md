# Log retention

This script reads a JSON configuration file and deletes old files in specified directories, 
keeping only the most recent ones based on a filename pattern.

- Reads `log_locations.json`, which contains entries with:
  - `directory`: path to search
  - `keep`: number of latest files to retain
  - `regex`: filename pattern to match
- Sorts files by modification time
- Deletes older files beyond the number to keep
- Supports a `debug` mode to print files that would be deleted

## Usage
```bash
./log_retention.sh         # Deletes old files as specified
./log_retention.sh debug   # Only prints which files would be deleted
```

## Example JSON
```json
[
  {
    "directory": "/home/user/logs/",
    "keep": 5,
    "regex": "*.log"
  },
  {
    "directory": "/var/backups/",
    "keep": 3,
    "regex": "*.tgz"
  }
]
```
