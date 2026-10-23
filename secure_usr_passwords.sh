#!/bin/bash
read -p "enter secure password for users: " secure
while IFS=: read -r user _ uid _; do
    [ "$uid" -ge 1000 ] && [ "$user" != "nobody" ] && || continue
    if id -nG "$user" | grep -qw "sudo"; then
        continue
    fi
    echo -e "\n"
    echo "$user (uid $uid)"
    echo "$secure" | sudo passwd --stdin "$user"
    echo -e "\n"
done < /etc/passwd
