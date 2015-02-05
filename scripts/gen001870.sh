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
#  - updated on Shannon Mitchell(shannon.mitchell@fusiontechnology-llc.com)
# on 15-jan-2012 to fix a typo and added .bash_logout and .bash_login to 
# the list. Fixed some logic with the find command.


#######################DISA INFORMATION###############################
#Group ID (Vulid): V-22361
#Group Title: GEN001870
#Rule ID: SV-26481r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN001870
#Rule Title: Local initialization files must be group-owned by the user's primary group or root.
#
#Vulnerability Discussion: Local initialization files are used to configure the user's shell environment upon login. Malicious modification of these files could compromise accounts upon logon.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Check user home directories for local initialization files group-owned by a group other than the user's primary group or root.
#
#Procedure:
# FILES=" .login .cschrc .logout .profile .bash_profile .bashrc .bash_logout .env .dtprofile .dispatch .emacs .exrc";
# for PWLINE in `cut -d: -f4,6 /etc/passwd`; do HOMEDIR=$(echo ${PWLINE}|cut -d: -f2);GROUP=$(echo ${PWLINE} | cut -d: -f1);for INIFILE in $FILES;do stat -c %g/%G:%n ${HOMEDIR}/${INIFILE} 2>null|egrep -v "${GROUP}";done;done

#If any file is not group-owned by root or the user's primary GID, this is a finding.
#
#Fix Text: Change the group-owner of the local initialization file to the user's primary group, or root.
# chgrp <user's primary GID> <user's local initialization file>
#
#Procedure:
# FILES=" .login .cschrc .logout .profile .bash_profile .bashrc .bash_logout .env .dtprofile .dispatch .emacs .exrc";
# for PWLINE in `cut -d: -f4,6 /etc/passwd`; do HOMEDIR=$(echo ${PWLINE}|cut -d: -f2);GROUP=$(echo ${PWLINE} | cut -d: -f1);for INIFILE in $FILES;do MATCH=$(stat -c %g/%G:%n ${HOMEDIR}/${INIFILE} 2>null|egrep -c -v "${GROUP}");if [ $MATCH != 0 ] ; then chgrp ${GROUP} ${HOMEDIR}/${INIFILE};fi;done;done
#######################DISA INFORMATION###############################

echo '==================================================='
echo ' Patching GEN001870: Initilization File Ownership'
echo '==================================================='

#Global Variables#
PDI=GEN001870

#Start-Lockdown
USERACCT=`egrep -v "^\+|^#|^root:|^daemon:|^ident:|^bin:|^sys:|^adm:|^smtp:|^uucp:|^nuucp:|^listen:|^lpd:|^lp:|^ingres:|^apache:|^oracle:|^oracle7:|^oracle8:|^oracle9:|^informix:|^news:|^nobody:|^nobody4:|^noaccess:|^sybase:|^tivoli:|^mqm:|^www:|^ftp:|^tftp:|^hpdb:|^sshd:|^invscout:|^gccs:|^secman:|^sysadmin:|^install:|^staff:|^COE:|^predmail:|^snmp:|^smmsp:|^sm:|^share:|^BIF:|^GCCS:|^JDISS:|^SA:|^SSO:|^SM:|^ftp:|^gccsrv:|^gtnsmint:|^irc:|^Imadmin:|^netadmin:|^halt:|^mail:|^games:|^rpm:|^vcsa:|^nscd:|^rpc:|^rpcuser:|^mailnull:|^pcap:|^xfs:|^ntp:|^gdm:|^sync:|^shutdown:|^halt:|^operator:|^gopher:|^nfsnobody:|^dbus:|^haldaemon:|^netdump:|^webalizer:|^pvm:|^mysql:|^mailman:|^dovecot:|^cyrus:|^amanda:|^pegasus:|^HPSMH:|^hpsmh:|^webadmind:|^webadmin:|^webservd:|^avahi:|^beagleidx:|^hsqldb:|^postfix:|^svctag:|^postgres:|^ids:|^IDS:|^distcache:|^DISTCACHE:|^named:|^canna:|^wnn:|^fax:|^quagga:|^htt|^tcpdump:" /etc/passwd | cut -d":" -f1` 

ALREADY=0
Answer=4
DotFiles='( -name .cshrc
		-o -name  .login
		-o -name  .logout
		-o -name  .bash_logout
		-o -name  .bash_login
		-o -name  .profile
		-o -name  .bash_profile
		-o -name  .bashrc
		-o -name  .env
		-o -name  .dtprofile
		-o -name  .dispatch
		-o -name  .emacs
		-o -name  .exrc )'

for UserName in ${USERACCT}; do
    if [ `echo $UserName | cut -c1` != '+' ]; then
        PwTest=`grep "^${UserName}:" /etc/passwd | cut -d: -f6`
        PwHomeDir=${PwTest:-NOVALUE}
        if [ "${PwHomeDir}" != "NOVALUE" -a "${PwHomeDir}" != " " ]; then
            if [ -d ${PwHomeDir} ]; then
                if [ ${PwHomeDir} = '/' ]; then
                    echo 'WARNING:  Home directory for "'${UserName}'"' \
                    '("'${PwHomeDir}'") excluded from check.'
                else
		    #Here is where we fix
		    PGID=`egrep "^${UserName}" /etc/passwd | awk -F':' '{print $4}'`
		    for filename in `find ${PwHomeDir}     \
		        -xdev                              \
                        -type f                            \
                        ! -fstype nfs                      \
                         ${DotFiles}                       \
                        ! -gid ${PGID}                     \
                        ! -gid 0                           \
                        -exec ls -adlL {} \;               \
                        | tr -s " " | awk '{print $9}'`; do
		        chgrp $PGID $filename
		    done
                fi
            fi
        fi
    fi
done
