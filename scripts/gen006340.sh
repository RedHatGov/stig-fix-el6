#!/bin/bash

## (GEN006340: CAT II) (Previously – L162) The SA will ensure the owner of all 
## files under the /etc/news subdirectory is root or news.
echo '==================================================='
echo ' Patching GEN006340: Set owner of /etc/news files'
echo '==================================================='
if [ -d /etc/news/ ]; then
	chown -R root /etc/news/*
fi
