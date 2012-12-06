#!/bin/bash

# day04 Kick-Start

# TEST BLOCK
        kulab="192.168.5.202"

echo "#### This installation is only for 32 bit #####"
echo "Press Ctrl+C to stop it"

# check_superuser
	if [ "$USER" != "root" ]; then
		echo "Superuser Privileges Requried!"
		exit
	fi

# fetching archives
wget -c "http://$kulab/archives/list" -O /tmp/list

while read i; do
    wget -c "http://$kulab/archives/$i" -O "/var/cache/apt/archives/$i"
done < /tmp/list

yes | apt-get install vlc