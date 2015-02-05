#!/bin/bash

## (GEN005740: CAT II) (Previously – G178) The SA will ensure the owner of the 
## export configuration file is root.
echo '==================================================='
echo ' Patching GEN005740: Set owner of export config file'
echo '==================================================='
chown root /etc/exports
