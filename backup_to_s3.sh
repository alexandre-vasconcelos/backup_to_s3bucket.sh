
#!/bin/bash
# Author: Alexandre Vasconcelos
# Bash: GNU bash, version 4.2.46(2)-release (x86_64-redhat-linux-gnu)
# O.S: Red Hat 4.8.5-16.0.3
# Version: 1.0
# Description: Backup files to bucket (s3 Compatible)

#file log
LOG="/var/log/nextcloud/backup_nexcloud_log-$(date +%d-%m-%Y-%H-%M).txt"
# data log
echo "Start backup at $(date +%d-%m-%Y-%H-%M)" >> $LOG
#dir origin
dir_orig="/home"

#dir destiny
dir_dest="/backup_nextcloud"

#name file
file_name="backup_nexcloud-$(date +%d-%m-%Y-%H-%M).tgz"
#compress
echo "Compress files $(date +%d-%m-%Y-%H-%M)" >> $LOG

tar czpf ${dir_dest}/${file_name} ${dir_orig} >> $LOG

echo "Size file is $(du -hs ${dir_dest}/${file_name})" >> $LOG

# copy files to bucket
echo "send files to cloud $(date +%d-%m-%Y-%H-%M)" >> $LOG

rclone move $dir_dest/$file_name oracle:Backup_System

echo "Backup finished  $(date +%d-%m-%Y-%H-%M)" >> $LOG
