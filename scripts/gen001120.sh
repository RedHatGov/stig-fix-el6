#!/bin/bash

## (GEN001120: CAT II) (Previously – G500) The SA will configure the 
## encryption program for direct root access only from the system console.
echo '==================================================='
echo ' Patching GEN001120: Do not allow root remote login'
echo '==================================================='
sed -i "/^#PermitRootLogin/ c\PermitRootLogin no" /etc/ssh/sshd_config
sed -i "/^PermitRootLogin/ c\PermitRootLogin no" /etc/ssh/sshd_config
