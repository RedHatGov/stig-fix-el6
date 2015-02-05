#!/bin/sh

## (GEN000400: CAT II) (Previously – G010) The SA will ensure a logon-warning banner is
## displayed on all devices and sessions at the initial logon.
echo '==================================================='
echo ' Patching GEN000400: Providing logon-warning banner'
echo '==================================================='

cmp -s ./config/issue /etc/issue
if [ $? -ne 0 ]; then
	cp ./config/issue /etc/issue
fi
exit 0
