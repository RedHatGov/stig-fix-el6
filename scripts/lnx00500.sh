#!/bin/bash

## (LNX00500: CAT II) (Previously – L206) The SA will ensure the group owner 
## of the /etc/sysctl.conf file is root.
echo '==================================================='
echo ' Patching LNX00500: Set sysctl.conf group owner'
echo '==================================================='
chgrp root /etc/sysctl.conf
