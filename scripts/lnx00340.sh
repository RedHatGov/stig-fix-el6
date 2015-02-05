#!/bin/sh

## (LNX00340: CAT II) (Previously – L142) The SA will delete accounts that
## provide no operational purpose, such as games or operator, and will delete
## the associated software.
echo '==================================================='
echo ' Patching LNX00340: Disable unnecessary accounts.'
echo '==================================================='
/usr/sbin/userdel news
/usr/sbin/userdel operator
/usr/sbin/userdel games
/usr/sbin/userdel gopher
/usr/sbin/userdel nfsnobody
/usr/sbin/userdel ftp
