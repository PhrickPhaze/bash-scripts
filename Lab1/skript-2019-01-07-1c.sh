#!/bin/bash

#The if statement keeps track of the number of characters which is needed in the while loop further down
if [ $# -gt 0 ]
	then
	a=`echo $1 | wc -c`
	a=`expr $a - 1`
	z=""
		#The while loop reverses the inputed with the correct number of characters
		while [ $a -gt 0 ]
		do
			b=`echo $1 | cut -c $a`
			a=`expr $a - 1`
			z=$z$b
		done
fi
#The output is then presented
echo -n "What you wrote is '"$z
echo "' backwards."
