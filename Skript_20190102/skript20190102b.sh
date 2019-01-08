#!/bin/bash

cd /usr/src

echo "The archive will be downloaded unless it exists"
if ! [ -f $1 ]
	then wget -O $1 https://github.com/PhrickPhaze/bash-scripts/archive/master.zip
fi

echo "Unless the folder already exists, it will be created"
if ! [ -d $2 ]
	then mkdir $2
fi

echo "The archive will be extracted to the folder"
unzip $1 -d $2

