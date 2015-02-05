#!/bin/bash
######################################################################
#By Tummy a.k.a Vincent C. Passaro				     #
#Vincent[.]Passaro[@]gmail[.]com	         		     #
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
#  - Updated by Shannon Mitchell(shannon.mitchell@fusiontechnology-llc.com) on 
# 30-dec-2011.  Added a check for existing permissions before making a change.
								     

#######################DISA INFORMATION###############################
#Group ID (Vulid): V-22327
#Group Title: GEN001371
#Rule ID: SV-26417r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN001371
#Rule Title: The /etc/nsswitch.conf file must be owned by root.
#
#Vulnerability Discussion: The nsswitch.conf file (or equivalent) configures the source of a variety of system security information including account, group, and host lookups. Malicious changes could prevent the system from functioning or compromise system security.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Check that the /etc/nsswitch.conf file is owned by root.
# ls -l /etc/nsswitch.conf
#If the file is not owned by root, this is a finding.
#
#Fix Text: Change the owner of the /etc/nsswitch.conf file to root.
# chown root /etc/nsswitch.conf    
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN001371

#Start-Lockdown
if [ -a "/etc/nsswitch.conf" ]; then
	echo '==================================================='
	echo ' Patching GEN001371: /etc/nsswitch.conf Ownership'
	echo '==================================================='
	CUROWN=`stat -c %U /etc/nsswitch.conf`;
	if [ "$CUROWN" != "root" ]; then
		chown root /etc/nsswitch.conf
  	fi
fi
