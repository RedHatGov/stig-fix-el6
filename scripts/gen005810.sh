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
# on 13-Feb-2012 to allow for all listed groups.


#######################DISA INFORMATION###############################
#Group ID (Vulid): V-22496
#Group Title: GEN005810
#Rule ID: SV-26820r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN005810
#Rule Title: All NFS-exported system files and system directories must be group-owned by root, bin, sys, or system.
#
#Vulnerability Discussion: Failure to give group-ownership of sensitive files or directories to root provides the members of the owning group with the potential to access sensitive information or change system configuration which could weaken the system's security posture.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#List the exports.
# cat /etc/exports
#For each file system displayed, check the ownership.
#
# ls -ldL <exported file system path>
#
#If the directory is not group-owned by root, this is a finding.
#
#Fix Text: Change the group owner of the export directory.
# chgrp root <export>    
#######################DISA INFORMATION###############################

echo '==================================================='
echo ' Patching GEN005810: NFS Exports Group Ownership'
echo '==================================================='

#Global Variables#
PDI=GEN005810

EXPORTDIRS=$( cat /etc/exports | awk '{print $1}' )
#Start-Lockdown
for line in $EXPORTDIRS; do
	if [ -a $line ]; then
		CURGOWN=`stat -c %G $line`
		if [ "$CURGOWN" != "root" -a "$CURGOWN" != "bin" -a "$CURGOWN" != "sys" -a "$CURGOWN" != "system" ]; then
			chgrp root $line
		fi
	fi
done
