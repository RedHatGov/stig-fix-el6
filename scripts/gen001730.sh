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
#  - updated by Shannon Mitchell(shannon.mitchell@fusiontechnology-llc.com)
# on 14-jan-2012 to fix a couple of bash typos.


#######################DISA INFORMATION###############################
#Group ID (Vulid): V-22356
#Group Title: GEN001730
#Rule ID: SV-26469r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN001730
#Rule Title: All global initialization files must not have extended ACLs.
#
#Vulnerability Discussion: Global initialization files are used to configure the user's shell environment upon login. Malicious modification of these files could compromise accounts upon logon.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Check global initialization files for extended ACLs:
#
# ls -l /etc/profile /etc/bashrc /etc/csh.login /etc/csh.cshrc /etc/environment /etc/.login /etc/security/environ /etc/profile.d/* 2>null|grep "\+ "
#
#If the permissions include a '+', the file has an extended ACL, this is a finding.
#
#Fix Text: Remove the extended ACL from the file.
#
# ls -l /etc/profile /etc/bashrc /etc/csh.login /etc/csh.cshrc /etc/environment /etc/.login /etc/security/environ /etc/profile.d/* 2>null|grep "\+ "|sed "s/^.* \///g"|xargs setfacl --remove-all
#######################DISA INFORMATION###############################
echo '==================================================='
echo ' Patching GEN001730: Remove ACLs from Init Files'
echo '==================================================='
#Global Variables#
PDI=GEN001730
GLOBALINIT=$( ls -l /etc/profile /etc/bashrc /etc/csh.login /etc/csh.cshrc /etc/environment /etc/.login /etc/security/environ /etc/profile.d/* 2>/dev/null|grep "\+ "|awk '{print $9}' )
#Start-Lockdown	

#THE DISA PROVIDED SUGGESTION DOES NOT WORK # TYPICAL

for line in $GLOBALINIT; do
	setfacl --remove-all $line
done
