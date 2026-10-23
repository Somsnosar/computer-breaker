#!/bin/bash
while IFS=: read -r user _ uid _; do
    [ "$uid" -ge 1000 ] && [ "$user" != "nobody" ] || continue

    echo "$user (uid $uid)"
    read -r -p "do kill? " existbool
    if [ "$existbool" = "y" ]; then
        sudo userdel -r "$user"
        continue
    fi

    read -r -p "do admin? " adminbool
    read -r -p "do password change? " passwordbool

    if [ "$adminbool" = "y" ]; then
        sudo usermod -aG sudo "$user"
    fi
    if [ "$passwordbool" = "y" ]; then
        sudo passwd "$user"
    fi
done < /etc/passwd
