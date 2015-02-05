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
# on 14-jan-2012 to modify user check for users >= 500, fixed the dotfiles to
# be excluded and added the fix to the find. Fixed secondary gid check.


#######################DISA INFORMATION###############################
#Group ID (Vulid): V-22351
#Group Title: GEN001550
#Rule ID: SV-26453r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN001550
#Rule Title: All files and directories contained in user home directories must be group-owned by a group of which the home directory's owner is a member.
#
#Vulnerability Discussion: If a user's files are group-owned by a group of which the user is not a member, unintended users may be able to access them.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Check the contents of user home directories for files group-owned by a group of which the home directory's owner is not a member.
#1. List the user accounts.
# cut -d : -f 1/etc/passwd
#2. For each user account, get a list of GIDs for files in the user's home directory.
# find ~username -printf %G\\n | sort | uniq
#3. Obtain the list of GIDs where the user is a member.
# id -G username
#4. Check the GID lists. If there are GIDs in the file list not present in the user list, this is a finding.

#Fix Text: Change the group of a file not group-owned by a group of which the home directory's owner is a member.
# chgrp <group with user as member> <file with bad group ownership>
#Document all changes. 
#######################DISA INFORMATION###############################

echo '==================================================='
echo ' Patching GEN001550: Home Directory File Ownership'
echo '==================================================='

#Global Variables#
PDI=GEN001550

#Start-Lockdown
DotFiles='( -name .cshrc
                -o -name  .login
                -o -name  .logout
                -o -name  .profile
                -o -name  .bash_profile
                -o -name  .bbashrc
                -o -name  .env
                -o -name  .dtprofile
                -o -name  .dispatch
                -o -name  .emacs
                -o -name  .exrc )'

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
		    # The rules says 'all' files and directories so here we go
		    # -xdev keeps it on the same filesystem
		    # ! -fstype nfs: keep from changing nfs filesystem files ?
		    # ! ${DotFiles}: do not check the . user init files ?
		    # ! -gid ( -gid primary_gid -o -gid secondary_gid...
		    #     makes sure the file is grp owned by either the primary
		    #     or one of the secondary groups of the user.

                    PWGID=`grep "^${UserName}:" /etc/passwd | cut -d: -f4`
		    GIDLINE="! ( -gid ${PWGID}"
		    for CGID in `id -G ${UserName}`; do
		
			if [ "$CGID" != "$PWGID" ]; then
		            GIDLINE="${GIDLINE} -o -gid ${CGID}"
			fi
		    done
		    GIDLINE="$GIDLINE )"

		    find ${PwHomeDir} -xdev ${GIDLINE} ! -fstype nfs  ! ${DotFiles} -exec chgrp ${PWGID} {} \; 2>/dev/null

                fi
            fi
        fi
    fi
done
