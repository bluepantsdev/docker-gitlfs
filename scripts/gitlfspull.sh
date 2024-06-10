#!/bin/bash

Version="0.0.1"
ENABLED=false
echo "You can use this script ($Version) to pull LFS files from a remote server."
echo "Just add your custom variables here and change the var 'ENABLED' to true."

if [ "$ENABLED" = "true" ]; then
  echo "Running the script..."
else
  echo "This script is not enabled. See the Docs. Exiting..."
  exit 1
fi

# source _cron.sh in the same dir as the script is if found
script_dir=$(realpath "$(dirname "$0")")
if [ -f $script_dir/_cron.sh ]; then
  source $script_dir/_cron.sh
else
  echo [🛑] "No _cron.sh found"
  exit 1
fi

## Vars
local_dataset=( "/data" )
# place the URLs of the repos you want to clone here
# make sure to add the trailing .git and that ssh keys are set up
# or use the https URL with the username and password (or token) in the URLs
repo_list=( "git://url/owner/repo.git" )
# for HTTPS URLs, you can use the following vars
gituser="username"
gittoken="token or key"

## Functions

function clone_or_pull_repos() {
  local_dataset=$1
  gituser=$2
  gittoken=$3
  declare -a repos=("${!4}")

  for repo in "${repos[@]}"; do
    repo_name=$(basename "$repo" .git)
    repo_dir="$local_dataset/$repo_name"

    # Add the username and password (or token) to the URL
    if [[ "$repo" != git://* ]] && [[ "$repo" != ssh://* ]]; then
        repo_url="https://${gituser}:${gittoken}@${repo#*//}"
    else
        repo_url=$repo
    fi

    if [ -d "$repo_dir" ]; then
      echo "Directory $repo_dir exists. Pulling..."
      echo git -C "$repo_dir" pull
      git -C "$repo_dir" pull

    else
      echo "Directory $repo_dir does not exist. Cloning..."
      echo git clone "$repo_url" "$repo_dir"
      git clone "$repo_url" "$repo_dir"
      # Initialize Git LFS
      git -C "$repo_dir" lfs install
    fi
  done
}

## Look at me go!
clone_or_pull_repos "$local_dataset" "$gituser" "$gittoken" repo_list[@]
