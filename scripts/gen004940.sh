#!/bin/bash

## (GEN004940: CAT II) (Previously – G143) The SA will ensure the ftpusers 
## file has permissions of 640, or more restrictive.
echo '==================================================='
echo ' Patching GEN004940: Set ftpusers permissions'
echo '==================================================='
chmod 640 /etc/ftpusers
