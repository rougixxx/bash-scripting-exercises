#!/bin/bash

# choosing the filesystem's dirs to monitor it's disk space usage in a array
filesystem=("/" "/root" "/home")
for i in ${filesystem[@]}; do 
	# getting the percentage number of disk space usage for each directery in the array of the filesystem
	usage=$(df -h $i | tail -n 1 | awk '{print $5}' | cut -d % -f 1)
	echo "Usage Percentage is: $usage%"
	#macking the necessary for monitoring
	if [ $usage -ge 80 ]; then
		alert="Running out of space on $i, Usage is: $usage%"
		echo "Sending out a disk space alert mail."
		#sending a warning message to the mail of the admin 
		echo $alert | mail -s "$i is $usage% full" pain@localhost
	fi
done
