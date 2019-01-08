#!/bin/bash

#Asking for input regarding what user
echo -n "Enter username: "
read u

#If input is 'exit', the script will terminate
if [ "$u" = exit ]
        then echo "Bye!"
        exit 0
fi

#Checking if the user exists, if not then the script restarts
getent passwd $u > /dev/null
if ! [ $? -eq 0 ]
	then echo "User '$u' does not exist, try again."
	/home/danny/bash-scripts/Lab1/20190107_Lab1a.sh #There are better ways to do this, I'm sure
	exit 0
fi

#Exit script if the input value is null
if  [ "$u" = "" ]
	then exit 0
fi

#Check if user is logged in or not
checkuser(){ who | grep -q "$u"; }

while ! checkuser "$u"; do
	echo "$u is not logged on"
	exit 0
done
echo "$u is logged on"
