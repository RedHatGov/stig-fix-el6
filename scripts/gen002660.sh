#!/bin/bash

## (GEN002660: CAT II) (Previously – G093) The SA will configure and implement
## auditing.
echo '==================================================='
echo ' Patching GEN002660: Turn on auditing'
echo '==================================================='
/sbin/chkconfig --levels 0123456 auditd on
