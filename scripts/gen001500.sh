#!/bin/sh
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
# on 12-jan-2012 to skip all checks on systems accounts(uid < 500). Added a 
# homedir permission check before running the chmod.

#######################DISA INFORMATION###############################
#Group ID (Vulid): V-902
#Group Title: Home Directories Ownership
#Rule ID: SV-902r7_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN001500
#Rule Title: All interactive user home directories must be owned by their respective users.
#
#Vulnerability Discussion: If users do not own their home directories, unauthorized users could access user files.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Check the ownership of each user home directory listed in the /etc/passwd file.
#
#Procedure:
# cut -d : -f 6 /etc/passwd | xargs -n1 ls -ld
#
#If any user home directory is not owned by the assigned user, this is a finding.
#
#Fix Text: Change the owner of a user's home directory to its assigned user.
#
#Procedure:
# chown <user> <home directory>  
#######################DISA INFORMATION###############################

echo '==================================================='
echo ' Patching GEN001500: Home Directory Ownership'
echo '==================================================='

#Global Variables#
PDI=GEN001500

#Start-Lockdown

# SLM: While testing, I saw several system accounts be listed for change which
# should be changed.  In order to skip all system accounts as defined in the 
# RHEL5 documentation, we are only checking those accounts >=500.
for UserName in `awk -F':' '!/nfsnobody/{if($3 >= 500) print $1}' /etc/passwd`; do
    if [ `echo $UserName | cut -c1` != '+' ]; then
        PwTest=`grep "^${UserName}:" /etc/passwd | cut -d: -f6`
        PwHomeDir=${PwTest:-NOVALUE}
        if [ "${PwHomeDir}" != "NOVALUE" -a "${PwHomeDir}" != " " ]; then
            if [ -d ${PwHomeDir} ]; then
                if [ ${PwHomeDir} = '/' ]; then
                    echo 'WARNING:  Home directory for "'${UserName}'"' \
                    '("'${PwHomeDir}'") excluded from check.'
                else
		    CUROWN=`stat -c %U ${PwHomeDir}`;
		    if [ "$CUROWN" != "$UserName" ]; then
		        chown $UserName ${PwHomeDir}
	 	    fi

                fi
            fi
        fi
    fi
done
