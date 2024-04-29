#! /usr/bin/bash

# MCX - Gather all users in the system. Show only the first 5 users alphabetically. 
#       The last one logged in has to be removed. Print the name of the user removed and the date he logged last.

echo -e "\n ---- Starting the Script 3 - Check users info ----\n"


echo -e " Gather all users in the system. Show only the first 5 users alphabetically: \n"

lastFive=$(getent passwd | cut -d: -f1 | sort | head -n 5)

echo $lastFive


# Function to get the real name of a user
get_real_name() {
    #local user_id=$(id -u "$1") ¿Really needed?
    local real_name=$(getent passwd "$1" | cut -d: -f5 | cut -d, -f1)
    echo "$real_name"
}


echo -e " The last one logged in has to be removed. Print the name of the user removed and the date he logged last. \n"

for user in $(getent passwd | cut -d: -f1 | sort | head -n 5); do

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