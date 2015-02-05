#!/bin/bash

## (GEN000540: CAT II) (Previously – G004) The SA will ensure passwords are 
## not changed more than once a day.
echo '==================================================='
echo ' Patching GEN000540: Set minimum number of days'
echo '                     between password changes'
echo '==================================================='
`/bin/grep PASS_MIN_DAYS /etc/login.defs | /bin/grep -q 1`
if [ $? -gt 0 ]; then
	sed -i '/^PASS_MIN_DAYS/ c\PASS_MIN_DAYS\t1' /etc/login.defs
fi
