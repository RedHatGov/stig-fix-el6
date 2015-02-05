#!/bin/bash

## (GEN001820: CAT II) The SA will ensure the owner of all default/skeleton
## dot files is root or bin.
echo '==================================================='
echo ' Patching GEN001820: Set owner of default/skel files'
echo '==================================================='
find /etc/skel -type f -exec chown root '{}' \;
