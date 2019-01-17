#!/bin/bash

#First the user is prompted to enter the number.
echo -n "Enter a number: "
read int
#The number inputed will start to count down to 0
for (( i=$int; i>=0; i-- ))
do
	#The output is printed out respectivily on each new line
	echo "$i "
done
echo ""

