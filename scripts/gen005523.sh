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
# on 04-Feb-2012 to check permissions before running chmod.


#######################DISA INFORMATION###############################
#Group ID (Vulid): V-22472
#Group Title: GEN005523
#Rule ID: SV-26765r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN005523
#Rule Title: The SSH private host key files must have mode 0600 or less permissive.
#
#Vulnerability Discussion: If an unauthorized user obtains the private SSH host key file, the host could be impersonated.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Check the permissions for SSH private host key files.
# ls -lL /etc/ssh/*key
#If any file has a mode more permissive than 0600, this is a finding.
#
#Fix Text: Change the permissions for the SSH private host key files.
# chmod 0600 /etc/ssh/*key   
#######################DISA INFORMATION###############################

echo '==================================================='
echo ' Patching GEN005523: SSH Private Key Permissions'
echo '==================================================='

#Global Variables#
PDI=GEN005523

#Start-Lockdown
find /etc/ssh -type f -name '*key' -exec chmod u-xs,g-rwxs,o-rwxt {} \;
