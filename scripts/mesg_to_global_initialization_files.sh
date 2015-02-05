#!/bin/bash

echo '==================================================='
echo ' Remediating: Add mesg -n to global'
echo '                     initialization files'
echo '==================================================='
for FILE in /etc/{profile,bashrc}; do
	`/bin/grep -q mesg $FILE`
	if [ $? -gt 0 ]; then
		echo "mesg n" >> $FILE
	fi
done;
