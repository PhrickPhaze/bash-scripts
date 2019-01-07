#!/bin/bash

cd /usr/share/

#Variables
fz=`find . -type f -size +1M | wc -l ` 
fzcp=`find . -type f -size +1M`
f1=$HOME/arkiv
f2=$HOME/arkiv_$(date +"%Y-%m-%d_%H'%M'%S")

#This statement determines an approximation of how many files you have
if [ "$fz" -ge 10000 ]
	then echo "Varning! Du har fler än 10000 filer!"
elif [ "$fz" -ge 1000 ]
	then echo "Varning! Du har fler än 1000 filer!"
elif [ "$fz" -ge 100 ]
	then echo "Varning! Du har fler än 100 filer!"
elif [ "$fz" -ge 10 ]
	then echo "Varning! Du har fler än 10 filer!"
fi

echo "-------" #aestetic

#Menu for archiving
while true; do
        echo "Welcome to Archiver!"
        echo "  1. List number of files"
        echo "  2. Archive all files"
	echo "  3. Quit"
read -p "-> " response

echo ""

#Operations based on input from user
case $response in
        1) find . -type f -size +1M | wc -l; echo "-------"  ;; 
        2) if [[ $f1 = $HOME/arkiv.zip ]] &
		then find . -type f -size +1M | zip -r $f1.zip -b $HOME -@ -q
		else find . -type f -size +1M | zip -r $f2.zip -b $HOME -@ -q
	fi;
	echo "-------";
	echo "$fz files have been archived!";
	echo "-------" ;;
	3) echo 'Bye!'; break ;;
        *) echo 'Wrong input, try again'; echo "-------" ;;
esac
done
