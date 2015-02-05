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
#Group ID (Vulid): V-4087
#Group Title: Local Initialization Files World Writable Programs
#Rule ID: SV-4087r6_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN001940
#Rule Title: User start-up files must not execute world-writable programs.
#
#Vulnerability Discussion: If start-up files execute world-writable programs, especially in unprotected directories, they could be maliciously modified to become trojans that destroy user files or otherwise #compromise the system at the user, or higher, level. If the system is compromised at the user level, it is much easier to eventually compromise the system at the root and network level.
#
#Responsibility: System Administrator
#IAControls: DCSW-1
#
#Check Content: 
#Check local initialization files for any executed world-writable programs or scripts and scripts executing from world writable directories.
#
#Procedure:
#For each home directory on the system make a list of files referenced within any local initialization script.
#Show the mode for each file and it's parent directory.
#
# FILES=".login .cshrc .logout .profile .bash_profile .bashrc .bash_logout .env .dtprofile .dispatch .emacs .exrc";
#
# for HOMEDIR in `cut -d: -f6 /etc/passwd|sort|uniq;do for INIFILE in $FILES;do REFLIST=`egrep " [\"~]?/" ${HOMEDIR}/${INIFILE} 2>null|sed "s/.*\([~ \"]\/[\.0-9A-Za-z_\/\-]*\).*/\1/"`;for REFFILE in $REFLIST;do FULLREF=`echo $REFFILE|sed "s:\~:${HOMEDIR}:g"|sed "s:^\s*::g"`;dirname $FULLREF|xargs stat -c "dir:%a:%n";stat -c "file:%:%n" $FULLREF;done;done;
#done|sort|uniq
#
#If any local initialization file executes a world-writable program or script or a script from a world -writable directory, this is a finding.
#
#Fix Text: Remove the world-writable permission of files referenced by local initialization scripts, or remove the references to these files in the local initialization scripts.    
#######################DISA INFORMATION###############################

echo '==================================================='
echo ' Patching GEN001940: Fix Init File Permissions'
echo '==================================================='

#Global Variables#
PDI=GEN001940

FILES=".login .cshrc .logout .profile .bash_profile .bashrc .bash_logout .env .dtprofile .dispatch .emacs .exrc"

DISAJUNK=$( for HOMEDIR in `cut -d: -f6 /etc/passwd | sort | uniq | grep -v "^/$"`; do 
  for INIFILE in $FILES; do 
	REFLIST=$( egrep " [\"~]?/" ${HOMEDIR}/${INIFILE} 2>/dev/null|sed "s/.*\([~ \"]\/[\.0-9A-Za-z_\/\-]*\).*/\1/")
      	for REFFILE in $REFLIST; do
		FULLREF=$( echo $REFFILE | sed "s:\~:${HOMEDIR}:g" | sed "s:^\s*::g" )
           	dirname $FULLREF|xargs stat -c "dir:%a:%n" | cut -d ":" -f 3 
           	stat -c "file:%:%n" $FULLREF | cut -d ":" -f 3 
      	done | sort | uniq
  done
done)

BADFILE=$( for file in $DISAJUNK; do
  	       #echo $file
  	       find $file -maxdepth 0 -perm -002 -type d  | grep $file 
	   done | sort | uniq )

#Start-Lockdown
for line in $BADFILE; do
    chmod o-w $line
done
