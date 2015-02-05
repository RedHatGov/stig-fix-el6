#!/bin/bash

## (GEN004360: CAT II) (Previously – G127) The SA will ensure the aliases file 
## is owned by root.
echo '==================================================='
echo ' Patching GEN004360: Set owner of aliases file'
echo '==================================================='
chown root /etc/aliases
