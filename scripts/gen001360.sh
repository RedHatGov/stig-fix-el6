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
#  - Updated by Shannon Mitchell(shannon.mitchell@fusiontechnology-llc.com
# on 09-jan-2012 to change the perm option in the find from and exact match
# to one that just finds the unwanted bits. Added file argument to the chmod
# command.
								     

#######################DISA INFORMATION###############################
#Group ID (Vulid): V-791
#Group Title: NIS/NIS+/yp File Permissions
#Rule ID: SV-27179r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN001360
#Rule Title: The NIS/NIS+/yp command files must have mode 0755 or less permissive.
#
#Vulnerability Discussion: NIS/NIS+/yp files are part of the system's identification and authentication processes and are, therefore, critical to system security. Unauthorized modification of these files could compromise these processes and the system.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Perform the following to check NIS file ownership:
# ls -la /var/yp/*;
#If the file's mode is more permissive than 0755, this is a finding.
#
#Fix Text: Change the mode of NIS/NIS+/yp command files to 0755 or less permissive.
#
#Procedure (example):
# chmod 0755 <filename>   
#######################DISA INFORMATION###############################

echo '==================================================='
echo ' Patching GEN001360: NIS File Permissions'
echo '==================================================='

#Global Variables#
PDI=GEN001360

if [ -d /var/yp ]; then
	BADYPFILE=`find /var/yp/ -type f -perm /7022`

	#Start-Lockdown
	for BADFILE in $BADYPFILE; do
		chmod u-s,g-ws,o-wt $BADFILE
	done
fi

