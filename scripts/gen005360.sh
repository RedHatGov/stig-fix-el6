#!/bin/bash

## (GEN005360: CAT II) The SA will ensure the owner of the snmpd.conf file is
## root with a group owner of sys and the owner of MIB files is root with a
## group owner of sys or the application.
echo '==================================================='
echo ' Patching GEN005360: Set owner of snmpd.conf file'
echo '==================================================='
if [ -e /etc/snmp/snmpd.conf ]; then
chown root:sys /etc/snmp/snmpd.conf
fi
