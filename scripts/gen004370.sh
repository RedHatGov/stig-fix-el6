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
# on 05-Feb-2012 to check group ownership before running chgrp.


#######################DISA INFORMATION###############################
#Group ID (Vulid): V-22438
#Group Title: GEN004370
#Rule ID: SV-26684r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN004370
#Rule Title: The sendmail alias files must be group-owned by root, or a system group.
#
#Vulnerability Discussion: If the aliases and aliases.db file are not group-owned by root or a system group, an unauthorized user may modify one or both of the files to add aliases to run malicious code or redirect e-mail.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Check the group ownership of the alias files.
#
#Procedure:
# ls -lL /etc/aliases
#If the files are not group-owned by root, this is a finding.
#
# ls -lL /etc/aliases.db
#If the file is not group-owned by the same system group as sendmail, which is smmsp by default, this is a finding.
#
#Fix Text: Change the group-owner of the /etc/aliases file.
#
#Procedure:
# chgrp root /etc/aliases
# chgrp postfix /etc/aliases.db
#
#The aliases.db file must be owned by the same system group as sendmail, which is smmsp by default.   
#######################DISA INFORMATION###############################

#Updated for RHEL6 and Postfix

#Global Variables#
PDI=GEN004370

#Start-Lockdown
if [[ -e /etc/aliases || -e /etc/aliases.db ]]; then
	echo '==================================================='
	echo ' Patching GEN004370: /etc/aliases Group Ownership'
	echo '==================================================='
fi

if [ -a "/etc/aliases" ]; then
	CURGROUP=`stat -c %G /etc/aliases`;
	if [  "$CURGROUP" != "root" ]; then
		chgrp root /etc/aliases
	fi
fi

if [ -a "/etc/aliases.db" ]; then
	CURGROUP=`stat -c %G /etc/aliases.db`;
	if [  "$CURGROUP" != "smmsp" ]; then
		chgrp postfix /etc/aliases.db
	fi
fi
