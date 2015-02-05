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
#
#  - updated by Shannon Mitchell(shannon.mitchell@fusiontechnology-llc.com)
# on 05-Feb-2012 to move from dev to prod and added partial fix


#######################DISA INFORMATION###############################
#Group ID (Vulid): V-22449
#Group Title: GEN005307
#Rule ID: SV-26723r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN005307
#Rule Title: The SNMP service must require the use of a FIPS 140-2 approved encryption algorithm for protecting the privacy of SNMP messages.
#
#Vulnerability Discussion: The SNMP service must use AES or a FIPS 140-2 approved successor algorithm for protecting the privacy of communications.
#
#Responsibility: System Administrator
#IAControls: DCNR-1
#
#Check Content: 
#Check that the SNMP daemon uses AES for SNMPv3 users.
#
#Procedure:
#Examine the default install location /etc/snmp/snmpd.conf
#or:
# find / -name snmpd.conf
#
#
# grep -v '^#' <snmpd.conf file> | grep -i createuser | grep -vi AES
#If any line is present this is a finding.
#
#Fix Text: Edit /etc/snmp/snmpd.conf and add the AES keyword for any createUser statement that does not have them.
#Restart the SNMP service.
# service snmpd restart   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN005307

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
		echo ' Patching GEN005307: SNMP FIPS 140-2 Ecryption'
		echo '==================================================='
		sed -i 's/^\(createUser.*\)DES\(.*\)/\1AES\2/g' /etc/snmp/snmpd.conf
		echo ""
		echo "   Please review /etc/snmp/snmpd.conf for manual changes"
		echo "   to the createUser option it should use SHA and AES in"
		echo "   the following format:"
		echo ""
		echo "         createUser <user> SHA passwd AES encyption"
		echo ""
	fi
fi
