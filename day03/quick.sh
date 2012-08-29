#!/bin/bash

# day03 Kick-Start


# TEST BLOCK
        kulab="192.168.5.202"
	
	if [ $SUDO_USER = "rho" ]; then
	    kulab="localhost/~rho"
	fi
	
	if [ $SUDO_USER = "rhoit" ]; then
    		kulab="10.0.2.2/~rho"
	fi	
	echo $kulab



echo "#### This installation is only for 32 bit #####"
echo "Press Ctrl+C to stop it"
pause;

# check_superuser
	if [ "$USER" != "root" ]; then
		echo "Superuser Privileges Requried!"
		exit
	fi

# Architecture
	_arch_="`uname -m`";

# Configure /etc/apt/source.list
	grep 'np.archive' /etc/apt/sources.list > /dev/null
	if [ $? = 1 ]; then
	    echo "######## CHANGING TO LOCAL UBUNTU SERVER #########"

	    cp /etc/apt/sources.list /etc/apt/sources.list.bak
	    sed -i 's/...archive/np.archive/g' /etc/apt/sources.list
	    apt-get update
	fi
	    
# Adding /etc/hosts
	grep 'kulab' /etc/hosts > /dev/null
	if [ $? = 1 ]; then
	    echo "######### MODIFING /etc/hosts ##########";
	    echo -e "\n192.168.5.202\tkulab # day03 Kick-Start script" >> /etc/hosts
	fi

# XLE
	if [ ! -d /home/$SUDO_USER/xle ]; then	   
	    echo "######### INSTALLING XLE ##########";
	    url="http://$kulab/installation/src/XLE/"
	    if [ "$_arch_" = "x86_64" ]; then
		pkg="xle-linux2.3-64-2012-04-25.tar.gz"
	    else
		pkg="xle-linux2.3-2012-04-25.tar.gz"
	    fi
	    
	    wget -c "$url$pkg" -O "/tmp/$pkg"
	    mkdir "/home/$SUDO_USER/xle"
	    cd "/home/$SUDO_USER/xle"
	    tar xzf "/tmp/$pkg"
	    chown $SUDO_USER . -R
	    chgrp $SUDO_USER . -R
	fi

# config bashrc
	grep "XLE BLOCK" "/home/$SUDO_USER/.bashrc" > /dev/null
	if [ $? = 1 ]; then
	    echo -e "\n###### Configure .bashrc ######"
	    echo -e "\n# START XLE BLOCK\n\t"\
'export XLEPATH="$HOME/xle"' "\n\t"\
'export PATH=${XLEPATH}/bin:$PATH' "\n\t"\
'export LD_LIBRARY_PATH=${XLEPATH}/lib:$LD_LIBRARY_PATH' "\n\t"\
'export DYLD_LIBRARY_PATH=${XLEPATH}/lib:$DYLD_LIBRARY_PATH' "\n\t"\
'export WEB_BROWSER=firefox' "\n"\
"# END XLE BLOCK" >>"/home/$SUDO_USER/.bashrc"
	fi

# Install Emacs
	yes | apt-get install emacs

# configure .emacs
	grep "LFG mode" "/home/$SUDO_USER/.emacs" > /dev/null
	if [ $? -gt 0 ]; then
	    echo -e "\n####### Adding LFG mode in .emacs ########"
	    echo -e "\n;;----------------------------------------------------------------------\n"\
";; LFG mode\n"\
"  (load-library \"/home/$SUDO_USER/xle/emacs/lfg-mode\")" >> "/home/$SUDO_USER/.emacs"
	fi


# Compling bitpar
	if [ ! -e /home/$SUDO_USER/bitpar ]; then	   
	    echo "######### INSTALLING BitPar ##########";
	    url="http://$kulab/installation/bin/"
	    pkg="bitpar"
	    cd "/home/$SUDO_USER"
	    wget -c "$url$pkg" -O "/home/$SUDO_USER/$pkg"
	    chown $SUDO_USER $pkg
	    chgrp $SUDO_USER $pkg
	fi

# Compling vpf
	yes | apt-get install tk tcl tclx8.4
	if [ ! -e /home/$SUDO_USER/vpf ]; then	   
	    echo "######### INSTALLING VPF ##########";
	    url="http://$kulab/installation/src/BitPar/"
	    pkg="vpf"
	    cd "/home/$SUDO_USER"
	    wget -c "$url$pkg" -O "/home/$SUDO_USER/$pkg"
	    chown $SUDO_USER $pkg
	    chgrp $SUDO_USER $pkg
	fi