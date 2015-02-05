#!/bin/bash

## (GEN003400: CAT II) (Previously – G625) The SA will ensure the at (or 
## equivalent) directory has permissions of 755, or more restrictive.
echo '==================================================='
echo ' Patching GEN003400: Set at directory permissions'
echo '==================================================='
chmod 755 /var/spool/at/spool
