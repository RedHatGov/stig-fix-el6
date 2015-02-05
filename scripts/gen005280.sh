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
#  - Updated by Shannon Mitchell(shannon.mitchell@fusiontechnology-llc.com)
# on 05-Feb-2012 to check service status before disabling it.


#######################DISA INFORMATION###############################
#Group ID (Vulid): V-4696
#Group Title: Disable UUCP
#Rule ID: SV-28429r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN005280
#Rule Title: The system must not have the UUCP service active.
#
#Vulnerability Discussion: The UUCP utility is designed to assist in transferring files, executing remote commands, and sending e-mail between UNIX systems over phone lines and direct connections between systems. The UUCP utility is a primitive and arcane system with many security issues. There are alternate data transfer utilities/products that can be configured to more securely transfer data by providing for authentication as well as encryption.
#
#Responsibility: System Administrator
#IAControls: ECSC-1
#
#Check Content: 
# chkconfig uucp
#or:
# chkconfig -list | grep uucp
#If uucp is found enabled, this is a finding.
#
#Fix Text: # chkconfig uucp off
# service uucp stop
# service xinetd restart   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN005280

#Start-Lockdown

chkconfig --list uucp 2>/dev/null | grep 'on' > /dev/null
if [ $? -eq 0 ]; then
echo '==================================================='
echo ' Patching GEN005280: Disable UUCP Daemon'
echo '==================================================='
	chkconfig uucp off
	service xinetd restart
fi

