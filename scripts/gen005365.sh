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
#Group ID (Vulid): V-22451
#Group Title: GEN005365
#Rule ID: SV-26731r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN005365
#Rule Title: The snmpd.conf file must be group-owned by root, bin, sys, or system.
#
#Vulnerability Discussion: The snmpd.conf file contains authenticators and must be protected from unauthorized access and modification. If the file is not group-owned by a system group, it may be subject to access and modification from unauthorized users.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Check the group ownership of the SNMP configuration file.
#
#Procedure:
#Examine the default install location /etc/snmp/snmpd.conf
#or:
# find / -name snmpd.conf
#
# ls -lL <snmpd.conf>
#
#If the file is not group-owned by root, bin, sys, or system, this is a finding.
#
#Fix Text: Change the group ownership of the SNMP configuration file.
#
#Procedure:
# chgrp root <snmpd.conf>   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN005365
SNMPDFILES=$( find / -name snmpd.conf -print )
#Start-Lockdown
if [ ! -z $SNMPDFILES ]; then
	echo '==================================================='
	echo ' Patching GEN005365: snmpd.conf Group Ownership'
	echo '==================================================='
	for LINE in $SNMPDFILES; do
		if [ -a $LINE ]; then
			CURGOWN=`stat -c %G $LINE`
			if [ "$CURGOWN" != "root" ]; then
				chgrp root $LINE
			fi
		fi
	done
fi
