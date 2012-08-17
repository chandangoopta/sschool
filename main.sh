#!/bin/bash

# MODIFING THE SOURCE LIST TO NP SERVER
sed 's/us\./np\./g' /etc/apt/sources.list

# SETTING UP THE PYTHON
apt-get install python-setuptools
easy install pip

pip install -U numpy pyyami nltk # NLTK


# SPHINX
while read i; do
    apt-get install i;
done < sphinx.list

# PRAAT
apt-get install praat

