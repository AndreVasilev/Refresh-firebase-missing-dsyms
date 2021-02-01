#!/bin/bash

green=`tput setaf 2`
reset=`tput sgr0`

#exit if any command fails

set -e

artifacts_directory=$1
dsyms_path="$artifacts_directory/dsyms"
script_path=$(dirname "${BASH_SOURCE[0]}")
upload_symbols="$script_path/upload-symbols"
google_service_info_plist="../GoogleService-Info.plist"

rm -rf $dsyms_path
mkdir $dsyms_path

parent_directory=$(dirname $artifacts_directory)
project_path=$(builtin cd $parent_directory; pwd)
project_name=${project_path##*/}

echo "${green}Preparing archives of $project_name${reset}"

counter=0
suffix=".dSYM.zip"

for entry in $artifacts_directory/*; do
    if [[ $entry == *$suffix ]]; then
        file_name=$(basename "$entry")
        dsym_name=${file_name/$suffix/}
        dsym_path="$dsyms_path/$dsym_name"
        ditto -xk $entry $dsym_path
        $upload_symbols -gsp $google_service_info_plist -p ios $dsym_path
        ((counter++))
        rm -rf $dsym_path
    fi
done

echo "${green}$counter dSYM archives of $project_name successfully uploaded${reset}"

rm -rf ./dsyms
