#!/bin/bash

## (GEN003420: CAT II) (Previously – G626) The SA will ensure the owner and 
## group owner of the at (or equivalent) directory is root, sys, bin, or daemon.
echo '==================================================='
echo ' Patching GEN003420: Set owner and group owner of'
echo '                     the at directory'
echo '==================================================='
chown root:root /var/spool/at/spool
