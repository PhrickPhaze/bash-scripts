#!/bin/bash

#Moving to the directory that was previously created to test the script here
cd /usr/src/test

#The initial question that will determine if the file already exists or not, is executable or not or if the user wishes to execute the file is possible.
echo -n "What is the name of the file? "
read file

#This if statement checks if the file exists or not, if it doesn't the option to create that file is presented
if [ ! -e $file ]
	then echo -n "'$file' does not exist. Do you want to create $file (y/n)? "
	read yn

		#This if statement creates the file and prompts the user if they want to execute the newly created file
		if [[ $yn = y ]]
			then touch $file
			echo -n "'$file' has been created! Do you want to execute '$file' (y/n)? "
			read x1

				#The following if statement executes the file if it is executable
				if [[ $x1 = y ]]
					then
						#If the file isn't executable, the option to make it executable is given here
						if [ -x $file ]
							then echo "Executing '$file'!"
							./$file
					else echo -n "'$file' is not executable, do you want to make '$file' executable (y/n)? "
					read x2

						#After the file is executable the option to execute the file is given
						if [[ $x2 = y ]]
							then chmod +x $file
							echo -n "'$file' is now executable, you wish you execute it (y/n)? "
							read x3
								#This innermost if statement finally executes the file is prompted with an 'y'. Any other input exits the script.
								if [[ $x3 = y ]]
									then echo "Executing '$file'"
									./$file
								elif [[ ! $x3 = y ]]
									then echo "Exiting script"
									exit 0
								else echo "Exiting script"
								exit 0
								fi
						elif [[ ! $x2 = y ]]
								then echo "Exiting script"
								exit 0
							else echo "Exiting script"
							exit 0
						fi
						fi
				elif [[ ! $x1 = y ]]
					then echo "Exiting script"
					exit 0
				else echo "Exiting script"
				exit 0
				fi
		elif [[ ! $yn = y ]]
			then echo "Exiting script"
			exit 0
		fi
#The second half of the initial if statement covers possibilites if the file already exists
	else echo -n "Do you want to execute '$file'(y/n)? "
	read ny
		#If the file already exists, the user is prompted to execute it if they choose to
		if [[ $ny = y ]]
			then
				#If the file isn't executable, the option to make it executable is presented
				if [ ! -x $file ]
					then echo -n "'$file' is not executable, do you want to make it executable (y/n)? "
					read x11
						#Based on user input they are prompted to execute the file
						if [[ $x11 = y ]]
							then chmod +x $file
							echo -n "'$file' is now executable, do you want to execute '$file' (y/n)? "
							read x12
								#Finally the existing file is executable and prompts the user to execute it if they choose to. Any input ##OTHER## than 'y' exists the script, which is 
								#presented by the elif statements and the else paramenters throughout the whole script in necessary areas.
								if [[ $x12 = y ]]
									then echo "Executing '$file'"
									./$file
								elif [[ ! $x12 = y ]]
									then echo "Exiting script"
									exit 0
									else echo "Exiting script"
									exit 0
								fi
						elif [[ ! $x11 = y ]]
							then echo "Exiting script"
							exit 0
						else echo "Exiting script"
						exit 0
						fi
					else echo "Executing '$file'"
					./$file
				fi
			elif [[ ! $ny = y ]]
				then echo "Exiting script"
				exit 0
			else "Exiting script"
			exit 0
		fi
fi
