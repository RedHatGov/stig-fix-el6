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
# on 05-Feb-2012 to include an ACL check before running setfacl.


#######################DISA INFORMATION###############################
#Group ID (Vulid): V-22437
#Group Title: GEN004010
#Rule ID: SV-26680r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN004010
#Rule Title: The traceroute file must not have an extended ACL.
#
#Vulnerability Discussion: If an extended ACL exists on the traceroute executable file, it may provide unauthorized users with access to the file. Malicious code could be inserted by an attacker and triggered whenever the traceroute command is executed by authorized users. Additionally, if an unauthorized user is granted executable permissions to the traceroute command, it could be used to gain information about the network topology behind the firewall. This information may allow an attacker to determine trusted routers and other network information that may lead to system and network compromise.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Check the permissions of the /bin/traceroute file.
# ls -lL /bin/traceroute
#If the permissions include a '+', the file has an extended ACL, this is a finding.
#
#Fix Text: Remove the extended ACL from the file.
# setfacl --remove-all /bin/traceroute  
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN004010

#Start-Lockdown

if [ -a "/bin/traceroute" ]; then
	echo '==================================================='
	echo ' Patching GEN004010: Remove ACLs from traceroute'
	echo '==================================================='

	ACLOUT=`getfacl --skip-base /bin/traceroute 2>/dev/null`;
	if [ "$ACLOUT" != "" ]; then
		setfacl --remove-all /bin/traceroute
	fi
fi

