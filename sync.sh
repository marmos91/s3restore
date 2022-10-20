#!bin/bash
set -e

local=$1
remote=$2
direction=$3

usage()
{
    echo "Usage: sync.sh <local> <remote> <direction>"
}

if [[ "$local" == "" ]]; then
    usage
    echo "You need to specify a local path" >&2
    exit 1
fi

if [[ "$remote" == "" ]]; then
    usage
    echo "You need to specify a remote path" >&2
    exit 1
fi

dsfile=$local/.DS_Store
dsfile_enc=$local/.DS_Store.enc

if [ -f "$dsfile" ] ; then
    rm $dsfile
fi

if [ -f "$dsfile_enc" ] ; then
    rm $dsfile_enc
fi

case $direction in
    up)
        echo "Running rclone sync -P $local $remote"
        rclone sync -P $local $remote
    ;;
    down)
        echo "Running rclone sync -P $remote $local"
        rclone sync -P $remote $local
    ;;
    *)
        usage
        echo "You have to specify a direction (up or down)" >&2
        exit 1
    ;;
esac

