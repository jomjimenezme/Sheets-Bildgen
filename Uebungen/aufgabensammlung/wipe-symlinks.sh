#!/bin/bash

find . -type l -printf '%p --> ' -exec readlink {} \;

read -p "The above symlinks are going to be deleted. Okay? [y/n] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
   echo "Deleting."
   find . -type l -delete
fi
