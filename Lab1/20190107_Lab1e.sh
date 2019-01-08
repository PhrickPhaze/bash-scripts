#!/bin/bash
#The variable i is set to 10 and while it is 10 it will count down to 1, hence the 'i>=1' and the 'i--' in the for loop.
for (( i=10; i>=1; i-- ))
do
	#The output is then written out on the same line.
	echo -n "$i "
done
echo ""
