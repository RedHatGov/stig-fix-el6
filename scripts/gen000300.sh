#!/bin/sh

## (GEN000300: CAT III) (Previously – G008) The SA will ensure
## each user is assigned a unique account name
echo '==================================================='
echo ' Checking GEN000300: Unique Account Names'
## (GEN000320: CAT II) (Previously – G009) The SA will ensure
## each user is assigned a unique uid
echo ' Checking GEN000320: Unique UID'
## (GEN000380: CAT IV) (Previously – G030) The SA will ensure
## each group referenced in the /etc/passwd file is defined in
## the /etc/group file
echo ' Checking GEN000380: Group Verfication'
echo '==================================================='
/usr/sbin/pwck -r
