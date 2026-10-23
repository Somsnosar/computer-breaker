#!/bin/bash
while IFS=: read -r user _ uid _; do
    [ "$uid" -ge 1000 ] && [ "$user" != "nobody" ] || continue
    if id -nG "$user" | grep -qw "sudo"; then
        continue
    fi
    echo -e "\n"
    echo "$user (uid $uid)"
    echo "$user:$(openssl rand -base64 12)" | sudo chpasswd
    sudo chage -d 0 "$user"
    echo -e "\n"
done < /etc/passwd
