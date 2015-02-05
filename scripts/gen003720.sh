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
# on 04-feb-2012 to check group ownership before running chown.


#######################DISA INFORMATION###############################
#Group ID (Vulid): V-821
#Group Title: GEN003720
#Rule ID: SV-27427r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN003720
#Rule Title: The xinetd.conf file, and the xinetd.d directory must be owned by root.
#
#Vulnerability Discussion: Failure to give ownership of sensitive files or utilities to system groups may provide unauthorized users with the potential to access sensitive information or change the system configuration which could weaken the system's security posture.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Check the group ownership of the xinetd configuration files and directories. RHEL5 does not include inetd service in its distribution. It has been replaced by xinetd.
#
#Procedure:
# ls -alL /etc/xinetd.conf /etc/xinetd.d
#
#If a file or directory is not owned by root this is a finding.
#
#Fix Text: Change the owner of the xinetd configuration files and directories.
#
#Procedure:
# chown -R root /etc/xinetd.conf /etc/xinetd.d   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN003730

#Start-Lockdown
if [ -e /etc/xinetd.conf ]; then
	echo '==================================================='
	echo ' Patching GEN003720: xinetd Files Ownership'
	echo '==================================================='

	find /etc/xinetd.conf /etc/xinetd.d/ ! -group root -exec chown root {} \; 2> /dev/null
fi
