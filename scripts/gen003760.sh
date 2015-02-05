#!/bin/bash

## (GEN003760: CAT II) (Previously – G109) The SA will ensure the owner of the 
## services file is root or bin.
echo '==================================================='
echo ' Patching GEN003760: Set owner of services file'
echo '==================================================='
chown root /etc/services
