#!/bin/bash

echo "If the folder doesn't exist, it will be created"
if ! [ -d $1 ]
	then mkdir $1
fi

echo "The file will be moved to the folder"
if ! [ -f $2 ]
	then touch $2
fi
mv $2 $1
