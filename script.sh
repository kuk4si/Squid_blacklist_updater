#!/bin/bash

wget=/usr/bin/wget
tar=/usr/bin/tar

OS="Ubuntu"
LOCATION="/var/squidGuard"
WGET_FILE_OUTPUT_NAME="squid_blacklist.tar"
DB_URL="http://dsi.ut-capitole.fr/blacklists/download/blacklists_for_pfsense.tar.gz"
FILENAME_DURING_UNTARRING="blacklists"
CUSTOM_BLACKLISTS=""
LOGDIRECTORY="/var/log/squidDBupdater"
LOGFILE="${LOGDIRECTORY}/logs"



#----------   Script   -------------


sudo echo -e "\n==================== $(date) ====================\n" >> $LOGFILE

(
sudo mkdir $LOGDIRECTORY
touch $LOGFILE
sudo rm -r $LOCATION/$FILENAME_DURING_UNTARRING
sudo $wget -qO $LOCATION/$WGET_FILE_OUTPUT_NAME $DB_URL

#try download file via WGET
if [[ "$?" != 0 ]]; then
    echo "[FATAL ERROR][$(date)] Can't download a file, check DB_URL!"
    exit 0
else
    echo "[$(date)]Success download BACKLISTS"
fi


if [ -z "$FILENAME_DURING_UNTARRING" ]
then
	echo "[$(date)] \$FILENAME_DURING_UNTARRING is empty." >> $LOGFILE
	sudo tar xzf $LOCATION/$WGET_FILE_OUTPUT_NAME -C $LOCATION/
else
	echo "[$(date)] Renaming tar output to '$FILENAME_DURING_UNTARRING'" >> $LOGFILE
	sudo mkdir $LOCATION/$FILENAME_DURING_UNTARRING && sudo tar xzf $LOCATION/$WGET_FILE_OUTPUT_NAME -C $LOCATION/$FILENAME_DURING_UNTARRING --strip-components 1
fi

sudo rm $LOCATION/$WGET_FILE_OUTPUT_NAME

if [ -z "$CUSTOM_BLACKLISTS" ]
then
	echo "[$(date)] Custom blacklists not found." >> $LOGFILE
else
	echo "[$(date)] Copy additional lists: $CUSTOM_BLACKLISTS" >> $LOGFILE
	sudo cp -R $CUSTOM_BLACKLISTS $LOCATION/$FILENAME_DURING_UNTARRING/
fi


#Restart Squid Service

if [[ $OS -eq "Ubuntu" ]]
then
	echo "[$(date)] Restarting Ubuntu Squid Service" >> $LOGFILE
	sudo systemctl restart squid
	echo "[$(date)] Done" >> $LOGFILE
elif [[ $OS -eq "Gentoo" ]]
then
	echo "[$(date)] Restarting Gentoo Squid Service" >> $LOGFILE
        sudo rc-service squid restart
        echo "[$(date)] Done" >> $LOGFILE
fi

) >> $LOGFILE 2>&1
