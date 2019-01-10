#!/bin/bash

#This menu is created with a while loop and case arguments. Each command corresponds to a number which the user inputs and that command is then executed.
while true; do
	echo "This is the command menu!"
	echo "  1. ls"
	echo "  2. pwd"
	echo "  3. ls -l"
	echo "  4. ps -fe"
	echo "  5. quit"

	read -p "-> " response

		case $response in

			1) ls ;;
			2) pwd ;;
			3) ls -l ;;
			4) ps -fe ;;
			5) echo "Bye!"; break ;;
			*) echo 'Command not found, try again' ;;
		esac
done
