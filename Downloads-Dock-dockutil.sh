#!/bin/bash

# Path to local downloads folder
local_downloads="/path"

# Path to downloads folder on external drive
external_downloads="/path"

# Function to check if the downloads folder is in the dock and add it if it is not
add_to_dock_if_needed() {
    # Gets the list of persistent items in the Dock
    dock_items=$(defaults read com.apple.dock persistent-others)

    # Check if the desired downloads folder is already in the Dock
    if echo "$dock_items" | grep -q "$2"; then
        # The correct downloads folder is already in the dock, do nothing
        true
    else
        # Check if the current folder is in the Dock before trying to delete it
        if echo "$dock_items" | grep -q "$1"; then
            echo "Removing old downloads folder from dock..."
            /path to dockutil --remove "$1" --no-restart
        fi
        echo "Adding new downloads folder to dock..."
        /path to dockutil --add "$2" --view auto --display folder --label "Downloads" --replacing "Downloads"
    fi
}

# Verifica la presencia de la unidad
if [ -d "$external_downloads" ]; then
    # If the external drive is mounted, check if it is needed to switch to the external downloads folder
    add_to_dock_if_needed "$local_downloads" "$external_downloads"
elif [ ! -d "$external_downloads" ]; then
    # If the external drive is not mounted, check if it is needed to switch to the local downloads folder
    add_to_dock_if_needed "$external_downloads" "$local_downloads"
fi
