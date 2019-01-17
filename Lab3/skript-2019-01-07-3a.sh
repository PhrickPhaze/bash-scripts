#!/bin/bash

#Variables
b=red

#First the question is asked to the user and then waits for input
echo -n "What is your favorite color? "
read a

#This is were we set the -correct- answer to the question.
c=`expr $a = $b`

#Here we test if the input matches our -correct- answer.
#It it matches, the then statement is presented and the script
#terminates. If the -wrong- answer is given the else statement
#is presented. Then it waits for 3 seconds, clears the screen
#and asks the same question again, without any -fixed- answers.
if [[ $c -eq 1 ]]
	then
	echo "Correct! Your favorite color is $a!"
	else
	echo "Wrong answer!"
	sleep 3
	clear

	echo -n "What is your favorite color? "
	read a
	echo "Correct! Your favorite color is $a!"

fi
