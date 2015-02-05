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
# on 12-jan-2012 to skip all checks on systems accounts(uid < 500). Added a 
# homedir permission check before running the chmod.


#######################DISA INFORMATION###############################
#Group ID (Vulid): V-903
#Group Title: Home Directories Group Ownership
#Rule ID: SV-903r7_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN001520
#Rule Title: All interactive user home directories must be group-owned by the home directory owner's primary group.
#
#Vulnerability Discussion: If the GID of the home directory is not the same as the GID of the user, this would allow unauthorized access to files.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Check the group ownership for each user in the /etc/passwd file.
#
#Procedure:
# cut -d : -f 6 /etc/passwd | xargs -n1 ls -ld
#
#If any user home directory is not group-owned by the assigned user’s primary group, this is a finding. Home directories for application accounts requiring different group ownership must be documented using site-defined procedures.
#
#Fix Text: Change the group-owner for user home directories to the primary group of the assigned user.
#
#Procedure:
#Find the primary group of the user (GID) which is the fourth field of the user entry in /etc/passwd.
#
# chgrp <GID> <user home directory>
#
#Document all changes.   
#######################DISA INFORMATION###############################
echo '==================================================='
echo ' Patching GEN001520: Home Directory Group Ownership'
echo '==================================================='

#Global Variables#
PDI=GEN001520

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

        	    PWGID=`grep "^${UserName}:" /etc/passwd | cut -d: -f4`
    		    CURGID=`stat -c %g ${PwHomeDir}`;
		    if [ "$CURGID" != "$PWGID" ]; then
		        chgrp $PWGID ${PwHomeDir}
		    fi
                fi
            fi
        fi
    fi
done

