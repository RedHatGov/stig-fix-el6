#!/bin/bash

## (GEN000700: CAT II) (Previously – G020) The SA will ensure passwords are
## changed at least every 90 days.
echo '==================================================='
echo ' Patching GEN000700: Set maximum number of days'
echo '                     between password changes'
echo '==================================================='
`grep PASS_MAX_DAYS /etc/login.defs | grep -q 60`
if [ $? -gt 0 ]; then
	sed -i '/^PASS_MAX_DAYS/ c\PASS_MAX_DAYS\t60' /etc/login.defs
fi
