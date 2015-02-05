#!/bin/sh

## (GEN004000: CAT II) (Previously – G633) The SA will ensure the traceroute
## command has permissions of 700, or more restrictive.
echo '==================================================='
echo ' Patching GEN004000: Limit access to traceroute to'
echo '                     root user only.'
echo '==================================================='
chmod 700 /bin/traceroute
