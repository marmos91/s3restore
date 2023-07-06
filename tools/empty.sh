#!/usr/bin/bash
set -e

usage() {
	echo "Usage: empty.sh <bucket>"
}

bucket=$1
endpoint="https://s3.cubbit.eu"
profile="cubbit"

if [[ "$bucket" == "" ]]; then
	usage
	echo "You need to specify a bucket" >&2
	exit 1
fi

keystodelete=$(aws s3api list-object-versions --endpoint $endpoint --profile $profile --bucket "$bucket")

if [[ $(echo "$keystodelete" | jq -c .) != ".Versions[]" && $(echo "$keystodelete" | jq -c .) != "null" ]]; then
	echo "Deleting keys..."
	echo "$keystodelete" | jq -r '.Versions[] | [.Key,.VersionId] | @csv' | while IFS="," read -r key version; do
		key=$(echo "$key" | xargs)
		version=$(echo "$version" | xargs)
		echo "Deleting key=$key, version=$version"
		aws s3api delete-object --endpoint "$endpoint" --profile "$profile" --bucket "$bucket" --key "$key" --version-id "$version" 2>&1 >/dev/null
	done
else
	echo "No keys to delete"
fi

echo "Bucket $bucket emptied"
