#!/usr/bin/env bash
#|---/ /+-----------------------------------+---/ /|#
#|--/ /-| Script to install flatpaks (user) |--/ /-|#
#|-/ /--| Prasanth Rangan                   |-/ /--|#
#|/ /---+-----------------------------------+/ /---|#

baseDir=$(dirname "$(realpath "$0")")
scrDir=$(dirname "$(dirname "$(realpath "$0")")")

source "${scrDir}/global_fn.sh"
if [ $? -ne 0 ]; then
    echo "Error: unable to source global_fn.sh..."
    exit 1
fi

if ! pkg_installed linyaps; then
    sudo pacman -S linyaps
fi

linyaps=$(awk -F '#' '{print $1}' "${baseDir}/custom_linyaps.lst" | sed 's/ //g' | xargs)

for flat in $linyaps; do
    if ll-cli list | awk '{print $1}' | grep "$flat"; then
        echo "$flat is already installed. Skipping."
    else
        ll-cli install "$flat"
    fi
done