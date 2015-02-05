#!/bin/bash

## (GEN003960: CAT II) (Previously – G631) The SA will ensure the owner of 
## the traceroute command is root.
echo '==================================================='
echo ' Patching GEN003960: Set traceroute comand owner'
echo '==================================================='
chown root /bin/traceroute
