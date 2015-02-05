#!/bin/sh

## (GEN000920: CAT II) (Previously – G023) The SA will ensure the root account
## home directory (other than ‘/’) has permissions of 700. Do not change the
## permissions of the ‘/’ directory to anything other than 0755.
echo '==================================================='
echo ' Patching GEN000920: /root is only readable by root'
echo '==================================================='
chmod 700 /root
