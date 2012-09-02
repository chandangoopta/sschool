#/bin/bash

wget -c http://kulab/archives/list -O /tmp/list

while read i; do
    wget -c "http://kulab/archives/$i" -O "/var/cache/apt/archives/$i"
done < /tmp/list