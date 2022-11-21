#!/bin/bash

servers=$(cat servers.txt)
echo -n "Enter the username please:"
read user
echo -n "Enter your UID:"
read uid

for server in $servers; do
	echo "Creating the user $user on the server $server with the UID $uid"
	ssh $serv "sudo useradd -m -u $uid $user"
	if [[ $? -eq 0 ]]; then
		echo "the USER $user is added on $server"
	else 
		echo "ERROR ON server $server"
	fi
done
