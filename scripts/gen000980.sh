#!/bin/sh

## (GEN000980: CAT II) (Previously – G026) The SA will ensure root can only log
## on as root from the system console, and then only when necessary to perform
## system maintenance.
echo '==================================================='
echo ' Patching GEN000980: Ensure only secure TTY.' 
echo '==================================================='
echo "console" > /etc/securetty
echo "tty1" >> /etc/securetty
