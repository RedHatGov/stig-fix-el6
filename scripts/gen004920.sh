#!/bin/bash

## (GEN004920: CAT II) (Previously – G142) The SA will ensure the owner of the 
## ftpusers file is root.
echo '==================================================='
echo ' Patching GEN004920: Set owner of ftpusers file'
echo '==================================================='
chown root /etc/ftpusers
