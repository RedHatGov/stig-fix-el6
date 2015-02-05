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
# on 24-jan-2012 to add a check for ACLs before removing them.


#######################DISA INFORMATION###############################
#Group ID (Vulid): V-22384
#Group Title: GEN002990
#Rule ID: SV-26526r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN002990
#Rule Title: The cron.allow file must not have an extended ACL.
#
#Vulnerability Discussion: A cron.allow file that is readable and/or writable by other than root could allow potential intruders and malicious users to use the file contents to help discern information, such as who is allowed to execute cron programs, which could be harmful to overall system and network security.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Check the permissions of the cron.allow file.
# ls -l /etc/cron.allow
#If the permissions include a '+', the file has an extended ACL, this is a finding.
#
#Fix Text: Remove the extended ACL from the file.
# setfacl --remove-all /etc/cron.allow   
#######################DISA INFORMATION###############################

echo '==================================================='
echo ' Patching GEN002990: Remove ACLs from /etc/cron.allow'
echo '==================================================='

#Global Variables#
PDI=GEN002990

#Start-Lockdown
ACLOUT=`getfacl --skip-base /etc/cron.allow 2>/dev/null`;
if [ "$ACLOUT" != "" ]; then
	setfacl --remove-all /etc/cron.allow
fi
