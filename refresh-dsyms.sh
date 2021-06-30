#!/bin/bash

#exit if any command fails
set -e

source_directory="Source"
cd $source_directory
exec_directory="."

appfile="Appfile"
appfile_path="fastlane/$appfile"
google_service_info_plist="GoogleService-Info.plist"
options_plist="options.plist"

credentials_directory="../Credentials"
logs_file="../logs.log"

for project in $credentials_directory/*; do
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] Start refresh dsyms of $(basename "$project")" >> $logs_file
    
    #Copy project's credentials
    rm -f "$exec_directory/$appfile_path"
    cp "$project/Appfile" "$exec_directory/$appfile_path"
    rm -f "$exec_directory/$google_service_info_plist"
    cp "$project/$google_service_info_plist" "$exec_directory/$google_service_info_plist"
    rm -f "$exec_directory/$options_plist"
    cp "$project/$options_plist" "$exec_directory/$options_plist"
    
    fastlane refresh_dsyms
    
    #Clear credentials
    rm -f "$exec_directory/$appfile_path"
    rm -f "$exec_directory/$google_service_info_plist"
    rm -f "$exec_directory/$options_plist"
    
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] Successfully refreshed dsyms of $(basename "$project")" >> $logs_file
done
