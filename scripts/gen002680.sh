#!/bin/bash

## (GEN002680: CAT II) (Previously – G094) The SA will ensure audit data files
## and directories will be readable only by personnel authorized by the IAO.
echo '==================================================='
echo ' Patching GEN002680: Set audit directory permissions'
echo '==================================================='
chmod 700 /var/log/audit
