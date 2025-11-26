#!/bin/bash
# shellcheck source=/dev/null
if [ -e .attrs.sh ]; then source .attrs.sh; fi
source "${stdenv:?}/setup"

export HOME
HOME=$(mktemp -d)

mkdir -p $out
mkdir -p downloadDir
cd downloadDir
if [ -z "$workshopId" ]; then
    steamcmd +force_install_dir "$(pwd)" +login anonymous +app_update $appId validate +quit
    sed -i 's/^\([[:space:]]*"LastUpdated"[[:space:]]*\)"[^"]*"/\1"0"/' ./steamapps/appmanifest_${appId}.acf
    cp -r . $out
else
    steamcmd +force_install_dir "$(pwd)" +login anonymous +workshop_download_item $appId $workshopId +quit
    cp -r ./steamapps/workshop/content/$appId/$workshopId/. $out
fi