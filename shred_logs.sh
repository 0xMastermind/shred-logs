#!/bin/bash

# Check if the script is running as root
if [ "$(id -u)" != "0" ]; then
    echo "This script must be run as root. Exiting."
    exit 1
fi

# Shred system log files
if find /var/log -type f \( -name "auth.log*" -o -name "lastlog*" -o -name "wtmp*" -o -name "btmp*" \) -exec shred -uzn 5 {} \; ; then
    echo "Successfully shredded system log files."
else
    echo "Error: Failed to shred system log files"
    exit 1
fi

# Shred root user's bash history
if shred -uzn 5 ~/.bash_history; then
    echo "Successfully shredded root user's bash history."
else
    echo "Error: Failed to shred root user's bash history"
    exit 1
fi

# Shred all users' bash history
if find /home -type f -name '.bash_history' -exec shred -uzn 5 {} \; ; then
    echo "Successfully shredded all users' bash history."
else
    echo "Error: Failed to shred all users' bash history"
    exit 1
fi




