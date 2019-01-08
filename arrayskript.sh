#!/bin/bash

names=([0]="Altaïr" [1]="Ezio" [2]="$USER" [3]="Connor" [4]="Edward")
for name in "${names[@]}"; do echo "$name" ; done | sort
