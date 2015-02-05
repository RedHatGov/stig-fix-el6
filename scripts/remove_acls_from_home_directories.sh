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
#Rule Title: User home directories must not have extended ACLs.
#
#Vulnerability Discussion: Excessive permissions on home directories allow unauthorized access to user files.
#
#Responsibility: System Administrator
#
#Check Content: 
#Check that user home directories have no extended ACLs.
# cut -d : -f 6 /etc/passwd | xargs -n1 ls -ld
#If the permissions include a '+', the file has an extended ACL this is a finding.
#
#Fix Text: Remove the extended ACL from the file.
# setfacl --remove-all [user home directory with extended ACL]   _

echo '==================================================='
echo ' Remediating: Remove ACLs from Home Directories'
echo '==================================================='

#Global Variables#
PDI=remove_acls_from_home_directories
ACLHOMEDIR=$(cut -d : -f 6 /etc/passwd | xargs -n1 ls -ld |grep '+' | awk '{print $9}')
#Start-Lockdown
for DIR in $ACLHOMEDIR; do
	if [ -d $DIR ]; then
    		setfacl --remove-all $DIR
	fi
done
