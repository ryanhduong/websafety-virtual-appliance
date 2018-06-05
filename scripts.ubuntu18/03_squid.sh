#!/bin/bash

# all packages are installed as root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

# move on to squid scripts folder
pushd scripts.squid4

# and build and install it
bash 01_tools.sh && bash 02_build.sh && bash 03_install.sh

# and return back
popd 
