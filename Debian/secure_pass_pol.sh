#!bin/bash
while IFS=: read -r user _ uid _; do
    [ "$uid" -ge 1000 ] && [ "$user" != "nobody" ] || continue
    echo -e "\n"
    chage -M 90 "$user"
    chage -m 7 "$user"
    chage -W 14 "$user"
    echo -e "\n"
done < /etc/passwd
