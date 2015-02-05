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
#Group ID (Vulid): V-22471
#Group Title: GEN005522
#Rule ID: SV-26764r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN005522
#Rule Title: The SSH public host key files must have mode 0644 or less permissive.
#
#Vulnerability Discussion: If a public host key file is modified by an unauthorized user, the SSH service may be compromised.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Check the permissions for SSH public host key files.
# ls -lL /etc/ssh/*key.pub
#If any file has a mode more permissive than 0644, this is a finding.
#
#Fix Text: Change the permissions for the SSH public host key files.
# chmod 0644 /etc/ssh/*key.pub   
#######################DISA INFORMATION###############################

echo '==================================================='
echo ' Patching GEN005522: SSH Public Key Permissions'
echo '==================================================='

#Global Variables#
PDI=GEN005522

#Start-Lockdown
find /etc/ssh -type f -name '*key.pub' -exec chmod u-xs,g-wxs,o-wxt {} \;
