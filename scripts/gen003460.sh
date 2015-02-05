#!/bin/bash

## (GEN003460: CAT II) (Previously – G629) The SA will ensure the owner and 
## group owner of the at.allow file is root.
echo '==================================================='
echo ' Patching GEN003460: Set owner and group owner of '
echo '                     the at.allow files'
echo '==================================================='
chown root:root /etc/at.allow
