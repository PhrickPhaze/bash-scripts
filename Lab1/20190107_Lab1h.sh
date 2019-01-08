#!/bin/bash
###################################################
#THE SCRIPTS 'txtcreator.sh' AND 'olddestroyer.sh'#
#ARE ONLY USED TO TEST THIS SCRIPT!               #
###################################################


#Initially the script checks to see if there are any .txt files in the current position, if not it will exit
file=`find . -type f -name '*.txt'`
if [[ ! $file ]]
	then echo "There are no .txt files to rename, exiting script."
	exit 0
	else
		#If there are .txt files, this for loop will rename all *.txt files to *.txt.old
		for file in *.txt; do
			mv "$file" "${file%.txt}.txt.old"
		done
fi
#Lastly the a confirmation message is displayed for the output
echo "All *.txt files have been renamed to *.txt.old!"
