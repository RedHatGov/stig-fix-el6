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
#Group ID (Vulid): V-22352
#Group Title: GEN001570
#Rule ID: SV-26454r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN001570
#Rule Title: All files and directories contained in user home directories must not have extended ACLs.
#
#Vulnerability Discussion: Excessive permissions allow unauthorized access to user files.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Check the contents of user home directories for files with extended ACLs.
# cut -d : -f 6 /etc/passwd | xargs -n1 -IDIR ls -alLR DIR
#If the permissions include a '+', the file has an extended ACL, this is a finding.
#
#Fix Text: Remove the extended ACL from the file.
# setfacl --remove-all <user file with extended ACL>    
#######################DISA INFORMATION###############################

echo '==================================================='
echo ' Checking GEN001570: Remove ACLs in Home Directories'
echo '==================================================='

#Global Variables#
PDI=GEN001570

HOMEDIRS=$(cut -d: -f6 /etc/passwd|sort|uniq|grep -v "^/$")

#Start-Lockdown
for DIR in $HOMEDIRS; do
	if [ -e $DIR ]; then
		setfacl -R --remove-all $DIR
	fi
done
