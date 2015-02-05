#!/bin/bash

## (GEN001620: CAT II) (Previously – G061) The SA will ensure run control 
## scripts files do not have the suid or sgid bit set.
echo '==================================================='
echo ' Patching GEN001620: Remove suid and sgid bit from'
echo '                     run control scripts.'
echo '==================================================='
chmod ug-s /etc/rc.d/init.d/*
