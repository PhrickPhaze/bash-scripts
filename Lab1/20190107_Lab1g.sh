#!/bin/bash

#The number inputed (as a command line argument) 
#will start to count down to 1 from that argument
for (( i=$1; i>=1; i-- ))
do
         #The output is printed out respectivily on each new line
        echo "$i "
done
