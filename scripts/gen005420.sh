#!/bin/bash

## (GEN005420: CAT II) (Previously – G657) The SA will ensure the group owner 
## of the /etc/syslog.conf file is root, sys, or bin.
echo '==================================================='
echo ' Patching GEN005420: Set group owner of syslog.conf'
echo '==================================================='
chgrp root /etc/syslog.conf
