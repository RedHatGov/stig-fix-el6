#!/bin/bash

## (GEN004480: CAT II) (Previously – G135) The SA will ensure the owner of the 
## critical sendmail log file is root.
echo '==================================================='
echo ' Patching GEN004480: Set owner of mail log file'
echo '==================================================='
chown root /var/log/maillog
