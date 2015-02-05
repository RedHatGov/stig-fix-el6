#!/bin/bash

## (LNX00420: CAT II) (Previously – L045) The SA will ensure the group owner 
## of the /etc/login.access or /etc/security/access.conf file is root.
echo '==================================================='
echo ' Patching LNX00420: Set access.conf group owner'
echo '==================================================='
chgrp root /etc/security/access.conf
