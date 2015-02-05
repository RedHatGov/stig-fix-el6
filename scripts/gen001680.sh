#!/bin/bash

## (GEN001680: CAT II) (Previously – G612) The SA will ensure the group owner 
## of run control scripts is root, sys, bin, other, or the system default.
echo '==================================================='
echo ' Patching GEN001680: Set group owner of run control'
echo '                     scripts'
echo '==================================================='
chgrp root /etc/rc.d/init.d/*
