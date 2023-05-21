#!/bin/bash

wget=/usr/bin/wget
tar=/usr/bin/tar

LOCATION="/var/squidGuard"
WGET_FILE_OUTPUT_NAME="squid_blacklist.tar"
DB_URL="http://dsi.ut-capitole.fr/blacklists/download/blacklists_for_pfsense.tar.gz"
FILENAME_DURING_UNTARRING="blacklists"
CUSTOM_BLACKLISTS="/home/andrey/Python/bashtop/*"


#----------   Script   -------------


sudo rm -r $LOCATION/$FILENAME_DURING_UNTARRING
sudo $wget -O $LOCATION/$WGET_FILE_OUTPUT_NAME $DB_URL

if [ -z "$FILENAME_DURING_UNTARRING" ]
then
	echo "\$FILENAME_DURING_UNTARRING is empty."
	sudo tar xzf $LOCATION/$WGET_FILE_OUTPUT_NAME -C $LOCATION/
else
	echo "Renaming tar output to '$FILENAME_DURING_UNTARRING'"
	sudo mkdir $LOCATION/$FILENAME_DURING_UNTARRING && sudo tar xzf $LOCATION/$WGET_FILE_OUTPUT_NAME -C $LOCATION/$FILENAME_DURING_UNTARRING --strip-components 1
fi

sudo rm $LOCATION/$WGET_FILE_OUTPUT_NAME

if [ -z "$CUSTOM_BLACKLISTS" ]
then
	echo "Custom blacklists not found."
else
	echo "Copy additional lists: $CUSTOM_BLACKLISTS"
	sudo cp -R $CUSTOM_BLACKLISTS $LOCATION/$FILENAME_DURING_UNTARRING/
fi
