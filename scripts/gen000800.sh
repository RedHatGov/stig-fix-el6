#!/bin/sh

## (GEN000800: CAT II) (Previously – G606) The SA will ensure passwords will not be
## reused within the last ten changes.
echo '==================================================='
echo ' Patching GEN000800: Disallow duplication passwords.'
echo '==================================================='
# See GEN000460 - handled by /etc/pam.d/system-auth-ac
