#!/bin/bash

# Check if the script is running as root
if [ "$(id -u)" != "0" ]; then
    echo "This script must be run as root. Exiting."
    exit 1
fi

# Shred system log files
shred -uzn 5 /var/log/auth.log /var/log/lastlog /var/log/wtmp /var/log/btmp || {
    echo "Error: Failed to shred system log files"
    exit 1
}

# Shred root user's bash history
shred -uzn 5 ~/.bash_history || {
    echo "Error: Failed to shred root user's bash history"
    exit 1
}

# Shred all users' bash history
find /home -type f -name '.bash_history' -exec shred -uzn 5 {} \; || {
    echo "Error: Failed to shred all users' bash history"
    exit 1
}


