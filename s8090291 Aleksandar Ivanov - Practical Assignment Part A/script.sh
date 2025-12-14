#!/bin/bash

# Function to backup user profile
backup_user_profile() {
    read -p "Enter username: " username

    if id "$username" &>/dev/null; then
        backup_dir="/home/$username/backup"
        restore_dir="/home/$username/restore"
        timestamp=$(date -u +%Y-%m-%d_%H%M%S)
        backup_filename="$timestamp-$username.tar.gz"

        mkdir -p "$backup_dir"
        tar -zcvf "$backup_dir/$backup_filename" "/home/$username"
        echo "Backup completed: $backup_filename"
    else
        echo "User $username does not exist."
    fi
}

# Function to restore user profile
restore_user_profile() {
    read -p "Enter username: " username

    if id "$username" &>/dev/null; then
        backup_dir="/home/$username/backup"
        restore_dir="/home/$username/restore"

        if [ -d "$backup_dir" ]; then
            echo "Backup archives:"
            select backup_filename in "$backup_dir"/*.tar.gz; 
            do
                if [ -n "$backup_filename" ]; 
                then
                    mkdir -p "$restore_dir"
                    tar -zxvf "$backup_filename" -C "$restore_dir"
                    echo "Restore completed."
                else
                    echo "Invalid selection."
                fi
        else
            echo "No backup archives found for $username."
        fi
    else
        echo "User $username does not exist."
    fi
}

# Option statement menu(loop)
option="0"

while [ $option -ne 3 ]
do 
    echo "========================="
    echo "Automated Script Menu"
    echo "========================="
    echo "[1] Backup User Profile "
    echo "[2] Restore User Profile "
    echo "[3] Quit this program "
    echo "========================="
    read -p "Select an option from the Menu: (1-3): " option
    
#case statement
    case $option in
        1) backup_user_profile;;
        2) restore_user_profile;;
        3) echo "You have selected to terminate this program bye!!";;
        *) echo "Not available option";;
    esac
    echo -n "Press enter to continue ..."; read;
done