#!/bin/bash
while IFS=: read -r user _ uid _; do
    [ "$uid" -ge 1000 ] && [ "$user" != "nobody" ] || continue

    echo -e "\n"
    echo "\n $user (uid $uid)"
    read -r -p "do kill? " existbool  < /dev/tty
    if [ "$existbool" = "y" ]; then
        sudo userdel -r "$user"
        echo "killed $user"
        continue
    fi

    read -r -p "do admin? " adminbool  < /dev/tty
    read -r -p "do password change? " passwordbool  < /dev/tty

    if [ "$adminbool" = "y" ]; then
        sudo usermod -aG sudo "$user"
        echo "sudoed $user"
    elif [ "$adminbool" = "n" ]; then
        sudo deluser "$user" sudo
        echo "de-sudoed $user"
    fi
    if [ "$passwordbool" = "y" ]; then
        sudo passwd "$user" < /dev/tty
    fi
    echo -e "\n"
done < /etc/passwd
