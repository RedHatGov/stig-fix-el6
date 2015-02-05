#!/bin/bash

## (GEN001660: CAT II) (Previously – G611) The SA will ensure the owner of run 
## control scripts is root.
echo '==================================================='
echo ' Patching GEN001660: Set owner of run control'
echo '                     scripts'
echo '==================================================='
chown root /etc/rc.d/init.d/*
