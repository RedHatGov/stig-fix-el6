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
# on 04-Feb-2012 to include an ACL check before running setfacl.


#######################DISA INFORMATION###############################
#Group ID (Vulid): V-22436
#Group Title: GEN003950
#Rule ID: SV-26676r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN003950
#Rule Title: The printers.conf file must not have an extended ACL.
#
#Vulnerability Discussion: Excessive permissions on the printers.conf file may permit unauthorized modification. Unauthorized modifications could disrupt access to local printers from authorized remote hosts or permit unauthorized remote access to local printers.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Check the permissions of the /etc/cups/printers.conf file.
# ls -lL /etc/cups/printers.conf/
#If the permissions include a '+', the file has an extended ACL, this is a finding.
#
#Fix Text: Remove the extended ACL from the file.
# setfacl --remove-all /etc/cups/printers.conf    
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN003950

#Start-Lockdown
if [ -a "/etc/cups/printers.conf" ];then
	echo '==================================================='
	echo ' Patching GEN003950: Remove ACLs from printers.conf'
	echo '==================================================='
	ACLOUT=`getfacl --skip-base /etc/cups/printers.conf 2>/dev/null`;
	if [ "$ACLOUT" != "" ]; then
		setfacl --remove-all /etc/cups/printers.conf
	fi
fi

