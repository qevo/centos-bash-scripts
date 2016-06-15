#!/bin/bash

# THIS DOES NOT WORK YET. MUST IMPROVE ZONE FILE SERIAL INCREMENTATION.

# zonesigner.sh example.com example.com.zone

# location of your zone files
ZONEDIR=`pwd`

ZONE=$1
ZONEFILE=$2

DNSSERVICE="named-chroot" #On CentOS/Fedora replace this with "named"

sudo cd $ZONEDIR

# retrieve the serial
#SERIAL=`sudo named-checkzone $ZONE $ZONEFILE | egrep -ho '[0-9]{10}'`


# increment the serial
sudo sed -i 's/'$SERIAL'/'$(($SERIAL+1))'/' $ZONEFILE

sudo dnssec-signzone -A -3 $(head -c 1000 /dev/random | sha1sum | cut -b 1-16) -N increment -o $1 -t $2
