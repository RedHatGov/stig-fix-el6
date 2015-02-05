#!/bin/bash

## (GEN001760: CAT II) The SA will ensure the group owner of global 
## initialization files is root, sys, bin, other, or the system default.
echo '==================================================='
echo ' Patching GEN001760: Set group owner of global'
echo '                     initialization files'
echo '==================================================='
chgrp root /etc/{profile,bashrc,environment}
