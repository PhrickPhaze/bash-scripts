#!/bin/bash

A=/usr/src/folder1
B=/usr/src/file1

cd /usr/src

echo "If the folder doesn't exist, it will be created"
if ! [ -d $A ]
	then mkdir $A
fi


echo "The file will be moved to the folder"
if ! [ -f $B ]
	then touch $B
fi

mv $B $A


