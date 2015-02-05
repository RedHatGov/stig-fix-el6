#!/bin/sh

## (GEN003320: CAT II) (Previously – G213) The SA will ensure default system 
## accounts (with the possible exception of root) are not listed in the 
## at.allow file. If there is only an at.deny file, the default accounts 
## (with the possible exception of root) will be listed there.
echo '==================================================='
echo ' Patching GEN003320: Only root may be in at.allow' 
echo '==================================================='
echo "root" > /etc/at.allow
