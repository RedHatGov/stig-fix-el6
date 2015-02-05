#!/bin/bash

## (GEN003980: CAT II) (Previously – G632) The SA will ensure the group 
## owner of the traceroute command is root, sys, or bin.
echo '==================================================='
echo ' Patching GEN003980: Set group owner of the'
echo '                     traceroute command'
echo '==================================================='
chgrp root /bin/traceroute
