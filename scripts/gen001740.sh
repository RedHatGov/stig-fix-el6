#!/bin/bash

## (GEN001740: CAT II) The SA will ensure the owner of global initialization 
## files is root.
echo '==================================================='
echo ' Patching GEN001740: Set owner of global'
echo '                     initialization files'
echo '==================================================='
chown root /etc/{profile,bashrc,environment}
