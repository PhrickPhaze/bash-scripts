#!/bin/bash

find /etc/* -mtime -2 -exec cp -r -f {} /usr/src/backup \;
#Filters the files that are to be backed up to folder 'backup'

archive=`date +"%Y-%m-%d"`
#Sets the variable for the file name

zip -r $archive.zip /usr/src/backup
#Compresses down the folder with the variable name

rm -r /usr/src/backup
#Removes the folder recursively
