#!/bin/bash
######################################################################
#By Tummy a.k.a Vincent C. Passaro		                     #
#Vincent[.]Passaro[@]gmail[.]com				     #
#www.vincentpassaro.com						     #
######################################################################
#_____________________________________________________________________
#|  Version |   Change Information  |      Author        |    Date    |
#|__________|_______________________|____________________|____________|
#|    1.0   |   Initial Script      | Vincent C. Passaro | 20-oct-2011|
#|	    |   Creation	    |                    |            |
#|__________|_______________________|____________________|____________|
#
#  - updated by Shannon Mitchell(shannon.mitchell@fusiontechnology-llc.com)
# on 05-Feb-2012 to move from dev to prod and added partial fix

#######################DISA INFORMATION###############################
#Group ID (Vulid): V-22448
#Group Title: GEN005306
#Rule ID: SV-26717r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN005306
#Rule Title: The SNMP service must require the use of a FIPS 140-2 approved cryptographic hash algorithm as part of its authentication and integrity methods.
#
#Vulnerability Discussion: The SNMP service must use SHA-1 or a FIPS 140-2 approved successor for authentication and integrity.
#
#Responsibility: System Administrator
#IAControls: DCNR-1
#
#Check Content: 
#Check that the SNMP daemon uses SHA for SNMPv3 users.
#
#Procedure:
#Examine the default install location /etc/snmp/snmpd.conf
#or:
# find / -name snmpd.conf
#
# grep -v '^#' <snmpd.conf file> | grep -i createuser | grep -vi SHA
#If any line is present this is a finding.
#
#Fix Text: Edit /etc/snmp/snmpd.conf and add the SHA keyword for any createUser statement that does not have them.
#Restart the SNMP service.
# service snmpd restart   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN005306

#Start-Lockdown

# man snmpd.conf
# ...
# createUser [-e ENGINEID] username  (MD5|SHA)  authpassphrase  [DES|AES] [privpassphrase]
# ...
# Based on the man pages the only option to SHA is MD5, so lets just change it.i
# Depending on how its used, changing it from MD5 to SHA may require manual
# changes.

if [ -e /etc/snmp/snmpd.conf ]; then
	grep 'createUser' /etc/snmp/snmpd.conf | grep 'MD5' >/dev/null
	if [ $? -eq 0 ]; then
		echo '==================================================='
		echo ' Patching GEN005306: SNMP FIPS 140-2 Ecryption'
		echo '==================================================='
		sed -i 's/^\(createUser.*\)MD5\(.*\)/\1SHA\2/g' /etc/snmp/snmpd.conf
		echo ""
		echo "   Please review /etc/snmp/snmpd.conf for manual changes"
		echo "   to the createUser option it should use SHA and AES in"
		echo "   the following format:"
		echo ""
		echo "         createUser <user> SHA passwd AES encyption"
		echo ""
	fi
fi
