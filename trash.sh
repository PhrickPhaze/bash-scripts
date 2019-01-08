#!/bin/bash
if [[ $DISPLAY ]]; then
	xterm -e top
else
	top
fi
