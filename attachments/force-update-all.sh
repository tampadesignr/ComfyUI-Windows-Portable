#!/bin/bash
# You need to install Git for Windows and select Git Bash (Default)
# https://git-scm.com/download/win

set -e

# If you don't want a FORCE update, remove "git reset" line
function change_url_or_pull () {
    git_remote_url=$(git -C "$1" remote get-url origin) ;

    if [[ $git_remote_url =~ ^(https:\/\/github\.com\/)(.*)(\.git)$ ]]; then
        echo "Updating: $1" ;
        git -C "$1" reset --hard ;
        git -C "$1" pull --ff-only ;
        echo "Done Updating: $1" ;
    fi ;
}

change_url_or_pull ComfyUI

cd ./ComfyUI/custom_nodes
for D in *; do
    if [ -d "${D}" ]; then
        change_url_or_pull "${D}" &
    fi
done

wait $(jobs -p)

exit 0
