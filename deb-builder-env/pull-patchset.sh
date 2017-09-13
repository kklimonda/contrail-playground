#!/bin/bash
set -euo pipefail
IFS=$'\t\n'

TARGET=$1
PATCHSET=$2

cd contrail/$TARGET
hash_ref=$(git ls-remote gerrit | egrep "refs/changes/.*$PATCHSET.*/" | tail -1)
hash=$(echo $hash_ref | cut -d' ' -f1)
ref=$(echo $hash_ref | cut -d' ' -f2)

git fetch gerrit $ref
git cherry-pick $hash
