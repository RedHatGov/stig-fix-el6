#!/bin/bash

## (GEN006360: CAT II) (Previously – L164) The SA will ensure the group owner 
## of all files in /etc/news is root or news.
echo '==================================================='
echo ' Patching GEN006360: Set group owner of /etc/news'
echo '                     files'
echo '==================================================='
if [ -d /etc/news/ ]; then
	chgrp -R root /etc/news/*
fi
