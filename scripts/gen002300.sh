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
# on 18-jan-2012 to update udev rules for tape devices.

#######################DISA INFORMATION###############################
#Group ID (Vulid): V-925
#Group Title: Device Files Ownership
#Rule ID: SV-925r7_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN002300
#Rule Title: Device files used for backup must only be readable and/or writable by root or the backup user.
#
#Vulnerability Discussion: System backups could be accidentally or maliciously overwritten and destroy the ability to recover the system if a compromise should occur. Unauthorized users could also copy system files.
#
#Responsibility: System Administrator
#IAControls: ECCD-1, ECCD-2
#
#Check Content: 
#Check the system for world-writable device files.
#
#Procedure:
# find / -perm -2 -a \( -type b -o -type c \) -exec ls -ld {} \;
#
#If any device file(s) used for backup are writable by users other than root, this is a finding.
#
#Fix Text: Use the chmod command to remove the world-writable bit from the backup device files.
#
#Procedure:
# chmod o-w <back device filename>
#
#Document all changes.
#######################DISA INFORMATION###############################

echo '==================================================='
echo ' Patching GEN002300: Device Files Ownership'
echo '==================================================='

#Global Variables#
PDI=GEN002300

#Start-Lockdown

# Pretty much any device that can be written to can be some sort of a backup 
# device, so lets start out with the tape device section in the udev rules.
# I've just copied the section from the 50-udev.rules default ruleset and 
# placed them in a lower numbered file to override the defaults.
#
# I have removed write from the disk group and added the owner entry as
# root just in case.
if [ ! -e "/etc/udev/rules.d/10-GEN002300.rules" ]; then

cat << EOF > /etc/udev/rules.d/10-GEN002300.rules
# tape devices
SUBSYSTEM=="ide", SYSFS{media}=="tape", ACTION=="add", \
                RUN+="modprobe $env{UDEV_MODPROBE_DBG} ide-scsi idescsi_nocd=1"
KERNEL=="ht*",                  OWNER=root, GROUP="disk", MODE="0640"
KERNEL=="nht*",                 OWNER=root, GROUP="disk", MODE="0640"
KERNEL=="pt[0-9]*",             OWNER=root, GROUP="disk", MODE="0640"
KERNEL=="npt*",                 OWNER=root, GROUP="disk", MODE="0640"
KERNEL=="st*",                  OWNER=root, GROUP="disk", MODE="0640"
KERNEL=="nst*",                 OWNER=root, GROUP="disk", MODE="0640"
KERNEL=="osst*",                OWNER=root, GROUP="disk", MODE="0640"
KERNEL=="nosst*",               OWNER=root, GROUP="disk", MODE="0640"

EOF

  chown root:root /etc/udev/rules.d/10-GEN002300.rules
  chmod 644 /etc/udev/rules.d/10-GEN002300.rules
 # chcon system_u:object_r:etc_t /etc/udev/rules.d/10-GEN002300.rules
  chcon "system_u:object_r:udev_var_run_t:s0" /etc/udev/rules.d/10-GEN002300.rules
fi
