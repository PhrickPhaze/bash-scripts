#!/bin/bash

#Variables
b=red

echo -n "What is your favorite color? "
read a


if [ $a = $b ]
	then
	echo "Correct! Your favorite color is $a!"
	else
	echo -n "Wrong answer!"

	sleep 3
	clear

	echo -n "What is your favorite color? "
	read c
	echo "Correct! Your favorite color is $c!"
fi
