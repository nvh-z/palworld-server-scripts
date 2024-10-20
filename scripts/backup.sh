#!/bin/sh
#DDATE=`date "+%F-%T"`
#cd /home/steam/palworld_backups/
#mkdir $DDATE
#cp -r /home/steam/palworld/Pal/Saved/SaveGames $DDATE/
#old stuff above

# Define source directory and backup directory
SOURCE_DIR="/home/steam/palworld/Pal/Saved/SaveGames"
BACKUP_DIR="/home/steam/palworld_backups"
DATE=$(date +%Y%m%d_%H%M%S)

# Create a gzip compressed tarball
tar -czf "${BACKUP_DIR}/backup_${DATE}.tar.gz" -C "${SOURCE_DIR}" .

echo "Backup of ${SOURCE_DIR} completed at ${BACKUP_DIR}/backup_${DATE}.tar.gz"
