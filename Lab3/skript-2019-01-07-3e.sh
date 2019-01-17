#!/bin/bash
echo "All lucky numbers between 1000 to 10000:"

#Variables
a=1001

#This while loop tests if the variable a is less than 10000,
#and if so it sets some new variables that are used furhter down.
while [ $a -lt 10000 ]
	do
	n=$a
	sd=0
	sum=0

	#This nested while loop tests if a newly created variable from the
	#previous do statement is greater than 0 or not. Then through a number
	#of variables and mathematic operations determines new values.
	while [ $n -gt 0 ]
		do
		sd=$(( $n % 10 ))
		n=$(( $n / 10 ))
		sum=$(( $sum + $sd ))
	done

	n=$sum
	sumdig=0
		#This while loop repeats the same concept as the
		#previous while loop, with some other mathematic operations.
		while [ $n -gt 0 ]
			do
			sd=$(( $n % 10 ))
			n=$(( $n / 10 ))
			sumdig=$(( $sumdig + $sd ))
		done
	#This if statement tests and sets new variables for the last time with its
	#corresponding mathematic expressions that prepares it for final output.
	if [ $sumdig -eq 10 ]
		then
		n=$sumdig
		sd=$(( $n % 10 ))
		n=$(( $n / 10 ))
		sumdig=$(( $sumdig + $sd ))
	fi
	if [ $sumdig -eq 7 ]
	then
	echo "$a"
	fi
	a=$(( $a + 1))
done
