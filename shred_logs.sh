#!/bin/bash

# Function to shred files with specified filename pattern
shred_files() {
    pattern=$1
    path=$2
    if [ ! -z "$(find $path -type f -name $pattern)" ]; then
        find $path -type f -name $pattern -exec shred -uzn 5 {} \;
        echo "Successfully shredded files with pattern $pattern in $path."
    else
        echo "Error: Failed to shred files with pattern $pattern in $path."
        exit 1
    fi
}

# Check if the script is running as root
if [ "$(id -u)" != "0" ]; then
    echo "This script must be run as root. Exiting."
    exit 1
fi

# Shred system log files
shred_files "auth.log*" "/var/log"
shred_files "lastlog*" "/var/log"
shred_files "wtmp*" "/var/log"
shred_files "btmp*" "/var/log"

# Shred root user's bash history
shred_files ".bash_history" "$HOME"

# Shred all users' bash history
shred_files ".bash_history" "/home"
