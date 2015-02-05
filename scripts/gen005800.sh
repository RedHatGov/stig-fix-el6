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
#Group ID (Vulid): V-931
#Group Title: Exported System Files and Directories Ownership
#Rule ID: SV-931r7_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN005800
#Rule Title: All NFS-exported system files and system directories must be owned by root.
#
#Vulnerability Discussion: Failure to give ownership of sensitive files or directories to root provides the designated owner and possible unauthorized users with the potential to access sensitive information or change system configuration which could weaken the system's security posture.
#
#Responsibility: System Administrator
#IAControls: ECSC-1
#
#Check Content: 
#Check for NFS exported file systems.
#
#Procedure:
# cat /etc/exports
#For each file system displayed, check the ownership.
#
# ls -lLa <exported file system path>
#
#If the files and directories are not owned by root, this is a finding.
#
#Fix Text: Change the ownership of exported file systems not owned by root.
#
#Procedure:
# chown root <path>   
#######################DISA INFORMATION###############################
echo '==================================================='
echo ' Patching GEN005800: Exported Files Ownership '
echo '==================================================='
#Global Variables#
PDI=GEN005800
EXPORTDIRS=$( cat /etc/exports | awk '{print $1}' )
#Start-Lockdown

for line in $EXPORTDIRS; do
	if [ -a $line ]; then
      		CUROWN=`stat -c %U $line`;
     
        	if [ "$CUROWN" != "root" ]; then
            		chown root $line
        	fi
    	fi
done

