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
#######################DISA INFORMATION###############################
#Group ID (Vulid): V-22452
#Group Title: GEN005375
#Rule ID: SV-26735r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN005375
#Rule Title: The snmpd.conf file must not have an extended ACL.
#
#Vulnerability Discussion: The snmpd.conf file contains authenticators and must be protected from unauthorized access and modification.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Check the permissions of the SNMP configuration file.
#
#Procedure:
#Examine the default install location /etc/snmp/snmpd.conf
#or:
# find / -name snmpd.conf
#
# ls -lL <snmpd.conf>
#
#If the permissions include a '+', the file has an extended ACL, this is a finding.
#
#Fix Text: Remove the extended ACL from the file.
# setfacl --remove-all <snmpd.conf file>    
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN005375
SNMPDFILES=$( find / -name snmpd.conf -print )
#Start-Lockdown
if [ ! -z $SNMPDFILES ]; then
	echo '==================================================='
	echo ' Patching GEN005375: Remove ACLs from snmpd.conf'
	echo '==================================================='
	for LINE in $SNMPDFILES; do
		if [ -a $LINE ]; then
			ACLOUT=`getfacl --skip-base $LINE 2>/dev/null`
			if [ "$ACLOUT" != "" ]; then
				setfacl --remove-all $LINE
			fi
	    	fi
	done
fi
