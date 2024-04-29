#! /usr/bin/bash

# MCX- Simple Shell script to check logged users

echo -e "\n ---- Starting the Script 2 - Check logged users ----\n"


# Function to get the real name of a user
get_real_name() {
    #local user_id=$(id -u "$1") ¿Really needed?
    local real_name=$(getent passwd "$1" | cut -d: -f5 | cut -d, -f1)
    echo "$real_name"
}

# Loop through all users listed in /var/log/wtmp
for user in $(last | awk '{print $1}'); do

    # Skip if the user is not logged in
    if ! last | grep "$user" | grep -q "still"; then
        continue
    fi

    # Get the real name of the user
    real_name=$(get_real_name "$user")
    # Get the last login time of the user
    last_login=$(last -n 1 "$user" | head -n 1 | awk '{print $5, $6, $7, $8}')
    echo -e "User: $real_name, Last Login: $last_login\n"
done


echo -e "---- Done ----\n"