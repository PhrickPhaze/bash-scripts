#!/bin/bash

#Function

function intstr
{
echo -n "What is your input? "
read a
if [[ $a =~ ^-?[0-9]+$ ]]
	then echo "'$a' is an integer!"
	else echo "'$a' is a string!"
fi
}
intstr
