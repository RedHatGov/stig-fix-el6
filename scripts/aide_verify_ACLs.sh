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
# on 16-Feb-2012 to move check from dev to prod and add fix.


#######################DISA INFORMATION###############################
#Rule Title: The file integrity tool must be configured to verify ACLs.
#
#Vulnerability Discussion: ACLs can provide permissions beyond those 
#permitted through the file mode and must be verified by file integrity tools.
#
#Responsibility: System Administrator
#
#Check Content: 
#If using AIDE, check that the configuration contains the "acl" option for all monitored files and directories.
#
#Procedure:
#Check for the default location /etc/aide/aide.conf
#or:
# find / -name aide.conf
#
# egrep "[+]?acl" <aide.conf file>
#If the option is not present. This is a finding.
#
#If using a different file integrity tool, check the configuration per tool documentation.
#
#Fix Text: If using AIDE, edit the configuration and add the "acl" option for all monitored files and directories.
#
#If using a different file integrity tool, configure ACL checking per the tool's documentation.   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=aide_verify_ACLs

#Start-Lockdown

# AIDE uses group when setting the permissions.  By default acls are turned on
# for most, but just incase this is run after changes were made lets make sure 
# acls are there.
#
# If a rule has 'R', 'L', '>' or 'acl' then acls are included in the check. 
#
# Start out by getting all file check definitions(line starting with a /)
# to get a list of used check groups.
if [ -e /etc/aide.conf ]; then
	echo '==================================================='
	echo ' Remediation: AIDE Configuration for ACLs '
	echo '==================================================='

	for GROUP in `awk '/^\//{print $2}' /etc/aide.conf | sort | uniq`; do
		CONFLINE=`awk "/^${GROUP}/{print \\$3}" /etc/aide.conf`
		if [[ "$CONFLINE" != *acl* ]] && [[ "$CONFLINE" != *R* ]]  && [[ "$CONFLINE" != *L* ]]  && [[ "$CONFLINE" != *\>* ]]; then
			NEWCONFLINE="${CONFLINE}+acl"
			sed -i -e "s/^${GROUP}.*/${GROUP} = $NEWCONFLINE/g" /etc/aide.conf
		fi
	done
fi
