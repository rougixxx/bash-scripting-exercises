#!/bin/bash

#specifiying the directeries we want to made backup for
#for example: /etc | /srv | /boot | ~/Desktop | ~/Downlaods
backup_dirs=("/etc" "/srv" "/boot" "/home/pain/Desktop" "/home/pain/Downloads")
#the destination server for the backup and the directory for putting the backup
#this is an example
dest_dir="/tmp/backup"
dest_server="root@192.168.1.102"

#getting the date of taking backup
backup_date=$(date +%b-%d-%Y-%H-%M-%S)

echo "Starting to grab the backup of: ${backup_dirs[@]}"

for i in "${backup_dirs[@]}"; do
	y=$i
	#gettig the last name in the path to name the backup_dir on it
	i=$(echo -n $i | rev | cut -d "/" -f 1 | rev)
	#doing the commpression
	sudo tar -Pczf /tmp/$i-$backup_date.tar.gz $y
	#checking if the operation is succeeded or not
	if [ $? -eq 0 ]; then 
		echo "$y backup succedded"
	else
		echo "$y backup failed !!"
	fi
	scp /tmp/$i-$backup_date.tar.gz $dest_server:$dest_dir
	#checking if the operation is succeeded or not
	if [ $? -eq 0 ]; then 
		echo "$y Transfer was succeeded!"
	else
		echo "$y Transfer failed!!"
	fi
done
#deleting all the compressed folders in /tmp dir
sudo rm /tmp/*.gz; echo "backup FINISHED !!"
