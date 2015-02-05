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
#Group ID (Vulid): V-4428
#Group Title: Access Control Files Accessibility
#Rule ID: SV-4428r7_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN002060
#Rule Title: All .rhosts, .shosts, .netrc, or hosts.equiv files must be accessible by only root or the owner.
#
#Vulnerability Discussion: The Berkeley r-commands are legacy services which allow cleartext remote access and have an insecure trust model and should never be used. However, if there has been a documented exception made for their use if the access control files are accessible by other than root or the owner, they could be used by a malicious user to set up a system compromise.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
# find / -name .rhosts
# ls -al /<directorylocation>/.rhosts
#
# find / -name .shosts
# ls -al /<directorylocation>/.shosts
#
# find / -name hosts.equiv
# ls -l /<directorylocation>/hosts.equiv
#
# find / -name shosts.equiv
# ls -l /<directorylocation>/shosts.equiv
#
#If the .rhosts, .shosts, hosts.equiv, or shosts.equiv files have permissions greater than 700, then this is a finding.
#
#
#Fix Text: Ensure the permission for these files is set at 600 and the owner is the owner of the home directory that it is in. These files, outside of home directories (other than hosts.equiv which is in /etc and owned by root), have no meaning.    
#######################DISA INFORMATION###############################

echo '==================================================='
echo ' Patching GEN002060: Access Control Permissions'
echo '==================================================='

#Global Variables#
PDI=GEN002060

GEN002060FILES=$( find / -name .rhosts -o -name  .shosts -o -name  hosts.equiv -o -name shosts.equiv )

#Start-Lockdown
for line in $GEN002060FILES; do
  chmod 700 $line
done








