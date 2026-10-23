#! /bin/bash
#
#
## PLAN:
# 1. Read each line from the user list file
# 2. Split each line into: username, group, comment
# 3. Make sure the group exists
# 4. If the user already exists, skip them
# 5. Otherwise create the user with their group and comment
# 6. Set a starter password + force change at first login
# 7. Print what happened for each user
#
#
#Default Env Variables
PASSWORD=rhel10 
#
#
# 1. Read each line from the user list file & Split each line into .....
while IFS=":" read -r username home_dir group1 comment; do
	    if id "$username" &>/dev/null; then
        echo "$username already exists, skipping"
        continue
    fi
	
	groupadd justice-league 2>/dev/null
	useradd -c "$comment" -d "$home_dir" -g justice-league -G "$group1" "$username"
	echo "$username":"$PASSWORD" | chpasswd 
	passwd -e "$username"
	echo "$username" created 

done < /home/don/create-users/justice-league-user.txt
