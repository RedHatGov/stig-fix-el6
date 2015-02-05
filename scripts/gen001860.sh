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
# on 15-jan-2012 to fix a typo and add .bash_logout and .bash_login to the list.


#######################DISA INFORMATION###############################
#Group ID (Vulid): V-904
#Group Title: Local Initialization Files Ownership
#Rule ID: SV-904r6_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN001860
#Rule Title: All local initialization files must be owned by the user or root.
#
#Vulnerability Discussion: Local initialization files are used to configure the user's shell environment upon login. Malicious modification of these files could compromise accounts upon logon.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#For each user in /etc/passwd with a home directory check the ownership of local initialization files.
#
#Procedure:
# files=" .login .cschrc .logout .profile .bash_profile .bashrc .bash_logout .env .dtprofile .dispatch .emacs .exrc";for pwline in `cut -d: -f1,6 /etc/passwd`; do homedir=`echo ${pwline}|cut -d: -f2`;username=`echo ${pwline} | cut -d: -f1`;for thisone in $files; do stat -c %U:%n ${homedir}/${thisone} 2>/dev/null|egrep -v "^(root|${username}):"; done;done
#and:
# for pwline in `cut -d: -f1,6 /etc/passwd`; do homedir=`echo ${pwline}|cut -d: -f2`;username=`echo ${pwline} | cut -d: -f1`;find ${homedir}/.dt ! -fstype nfs ! -user ${username} -exec stat -c %U:%n {} \; 2>/dev/null; done
#
#If local initialization files are not owned by the home directory user, this is a finding.
#
#Fix Text: Change the ownership of the startup and login files in the user’s directory to the user or root, as appropriate. Examine each user’s home directory and verify that all filenames that begin with "." are owned by the owner of the directory or root. If they are not, use the chown command to change the owner to the user and research the reasons why the owners were not assigned as required.
#
#Procedure:
# chown <username> <dot filename>
#Document all changes.
#######################DISA INFORMATION###############################

echo '==================================================='
echo ' Patching GEN001860: Local Init File Ownership'
echo '==================================================='

#Global Variables#
PDI=GEN001860

#Start-Lockdown

USERACCT=`egrep -v "^\+|^#|^root:|^daemon:|^ident:|^bin:|^sys:|^adm:|^smtp:|^uucp:|^nuucp:|^listen:|^lpd:|^lp:|^ingres:|^apache:|^oracle:|^oracle7:|^oracle8:|^oracle9:|^informix:|^news:|^nobody:|^nobody4:|^noaccess:|^sybase:|^tivoli:|^mqm:|^www:|^ftp:|^tftp:|^hpdb:|^sshd:|^invscout:|^gccs:|^secman:|^sysadmin:|^install:|^staff:|^COE:|^predmail:|^snmp:|^smmsp:|^sm:|^share:|^BIF:|^GCCS:|^JDISS:|^SA:|^SSO:|^SM:|^ftp:|^gccsrv:|^gtnsmint:|^irc:|^Imadmin:|^netadmin:|^halt:|^mail:|^games:|^rpm:|^vcsa:|^nscd:|^rpc:|^rpcuser:|^mailnull:|^pcap:|^xfs:|^ntp:|^gdm:|^sync:|^shutdown:|^halt:|^operator:|^gopher:|^nfsnobody:|^dbus:|^haldaemon:|^netdump:|^webalizer:|^pvm:|^mysql:|^mailman:|^dovecot:|^cyrus:|^amanda:|^pegasus:|^HPSMH:|^hpsmh:|^webadmind:|^webadmin:|^webservd:|^avahi:|^beagleidx:|^hsqldb:|^postfix:|^svctag:|^postgres:|^ids:|^IDS:|^distcache:|^DISTCACHE:|^tcpdump:|^named:|^canna:|^wnn:|^fax:|^tomcat:|^quagga:|^htt" /etc/passwd | cut -d":" -f1` 

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

#                    find ${PwHomeDir}                   \
#			-xdev                           \
#                        -type f                         \
#                        ! -fstype nfs                   \
#                         ${DotFiles}                   \
#                        ! -user ${UserName}             \
#                        -exec ls -adlL {} \;            \
#                        | tr -s " "   
						
					#Here is where we fix
					for filename in `find ${PwHomeDir}                   \
			-xdev                           \
                        -type f                         \
                        ! -fstype nfs                   \
                         ${DotFiles}                   \
                        ! -user ${UserName}             \
                        -exec ls -adlL {} \;            \
                        | tr -s " " | awk '{print $9}'`
					do
						#echo "We Gonna fix like this"
						GroupName=`id $UserName|cut -d "(" -f 4|tr ")" " "`
						#echo " $UserName:$GroupName $filename"
						chown $UserName $filename
					done
                fi
            fi
        fi
    fi
done
