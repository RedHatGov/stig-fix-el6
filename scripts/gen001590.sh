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
#Group ID (Vulid): V-22353
#Group Title: GEN001590
#Rule ID: SV-26458r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN001590
#Rule Title: All run control scripts must have no extended ACLs.
#
#Vulnerability Discussion: If the startup files are writable by other users, they could modify the startup files to insert malicious commands into the startup files.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Check that run control scripts have no extended ACLs.
# ls -lL /etc/rc* /etc/init.d
#If the permissions include a '+', the file has an extended ACL, this is a finding.
#
#Fix Text: Remove the extended ACL from the file.
# setfacl --remove-all <run control script with extended ACL>   
#######################DISA INFORMATION###############################

echo '==================================================='
echo ' Patching GEN001500: Remove ACLs for Init Scripts'
echo '==================================================='

#Global Variables#
PDI=GEN001590
BADFACL=$( getfacl -R --skip-base --absolute-names /etc/rc.* /etc/init.d | grep file| awk '{print $3}')
#Start-Lockdown
for BADFILE in $BADFACL; do
	if [ -e $BADFILE ]; then
		setfacl --remove-all $BADFILE
	fi
done

