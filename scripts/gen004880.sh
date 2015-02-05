#!/bin/bash

## (GEN004880: CAT II) (Previously – G140) The SA will ensure the ftpusers 
## file exists.
echo '==================================================='
echo ' Patching GEN004880: Create ftpusers file'
echo '==================================================='
touch /etc/ftpusers
