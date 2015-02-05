#!/bin/bash

## (GEN004500: CAT II) (Previously – G136) The SA will ensure the critical
## sendmail log file has permissions of 644, or more restrictive.
echo '==================================================='
echo ' Patching GEN004500: Set mail log file permissions'
echo '==================================================='
chmod 640 /var/log/maillog
