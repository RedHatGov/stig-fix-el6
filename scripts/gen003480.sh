#!/bin/bash

## (GEN003480: CAT II) (Previously – G630) The SA will ensure the owner and 
## group owner of the at.deny file is root.
echo '==================================================='
echo ' Patching GEN003480: Set owner and group owner of'
echo '                     the at.deny file'
echo '==================================================='
chown root:root /etc/at.deny
