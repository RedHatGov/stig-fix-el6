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
#Group ID (Vulid): V-22362
#Group Title: GEN001890
#Rule ID: SV-26482r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN001890
#Rule Title: Local initialization files must not have extended ACLs.
#
#Vulnerability Discussion: Local initialization files are used to configure the user's shell environment upon login. Malicious modification of these files could compromise accounts upon logon.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Check user home directories for local initialization files that have extended ACLs.
# cut -d : -f 6 /etc/passwd | xargs -n1 -IDIR ls -alL DIR/.login DIR/.cschrc DIR/.logout DIR/.profile DIR/.bash_profile DIR/.bashrc DIR/.bash_logout DIR/.env DIR/.dtprofile DIR/.dispatch DIR/.emacs DIR/.exrc
#If the permissions include a '+', the file has an extended ACL, this is a finding.
#
#Fix Text: Remove the extended ACL from the file.
# setfacl --remove-all <local initialization file with extended ACL>   
#######################DISA INFORMATION###############################

echo '==================================================='
echo ' Patching GEN001890: Remove ACLs from Initilization'
echo '                     Files'
echo '==================================================='


#Global Variables#
PDI=GEN001890

HOMEDIR=$( cut -d : -f 6 /etc/passwd | grep -v "^/$" )
BADFACL=$( for line in $HOMEDIR; do getfacl --absolute-names --skip-base $line/.login $line/.cschr $line/.logout $line/.profile $line/.bash_profile $line/.bashrc $line/.bash_logout $line/.env $line/.dtprofile $line/.dispatch $line/.emacs $line/.exrc 2>/dev/null | grep "# file:" | cut -d ":" -f 2; done )


#Start-Lockdown
for FILE in $BADFACL; do
	if [ -e $FILE ]; then
		setfacl --remove-all $FILE
	fi
done
