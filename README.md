# S3 restore

A set of tools to empty, restore and sync buckets.

## Tools available

- [Empty](./tools/empty.sh): a script to empty a bucket (it deletes all versions)
- [Sync](./tools/sync.sh): a script to sync a folder with a remote bucket. It uses [RClone](https://rclone.org/) under the hood
- [Restore](./tools/restore.sh): it restores a given bucket, after it has been encrypted with [this demo ransomware](https://github.com/marmos91/ransomware).
