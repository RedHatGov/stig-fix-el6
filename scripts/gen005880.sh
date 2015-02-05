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
# on 13-Feb-2012 to move from dev to prod and add fix.


#######################DISA INFORMATION###############################
#Group ID (Vulid): V-935
#Group Title: Root Access Option Documentation
#Rule ID: SV-30225r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN005880
#Rule Title: The NFS server must not allow remote root access.
#
#Vulnerability Discussion: If the NFS server allows root access to local file systems from remote hosts, this access could be used to compromise the system.
#
#Responsibility: System Administrator
#IAControls: EBRP-1
#
#Check Content: 
#List the exports.
# cat /etc/exports
#If any export contains no_root_squash or does not contain root_squash or all_squash, this is a finding.
#
#Fix Text: Edit the /etc/exports file and add root_squash (or all_squash) and remove no_root_squash.
#######################DISA INFORMATION###############################

echo '==================================================='
echo ' Patching GEN005880: Remove Root Access from NFS'
echo '==================================================='

#Global Variables#
PDI=GEN005880

#Start-Lockdown
grep -v 'root_squash' /etc/exports > /dev/null
if [ $? -eq 0 ]; then
  sed -i -e '/root_squash/! s/\(.*\))/\1,root_squash\)/g' /etc/exports
  exportfs -a
fi

grep no_root_squash /etc/exports > /dev/null
if [ $? -eq 0 ]; then
  sed -i -e 's/no_root_squash/root_squash/g' /etc/exports
fi

