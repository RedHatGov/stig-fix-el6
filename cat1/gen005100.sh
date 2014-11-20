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
# on 05-Feb-2012 to check permissions before running chmod and to allow for 
# "less permissive" permissions.
# superceded by RHEL-06-000222 
# luke.brisk@boeing.com or luke.brisk@gmail.com

#######################DISA INFORMATION###############################
#Group ID (Vulid): V-848
#Group Title: TFTP SUID/SGID Bit
#Rule ID: SV-848r7_rule
#Severity: CAT I
#Rule Version (STIG-ID): GEN005100
#Rule Title: The TFTP daemon must have mode 0755 or less permissive.
#
#Vulnerability Discussion: If TFTP runs with the setuid or setgid bit set, it may be able to write to any file or directory and may seriously impair system integrity, confidentiality, and availability.
#
#Responsibility: System Administrator
#IAControls: ECPA-1
#
#Check Content: 
#Check the mode of the TFTP daemon.
#
#Procedure:
# grep "server " /etc/xinetd.d/tftp
# ls -lL <in.tftpd binary>
#
#If the mode of the file is more permissive than 0755, this is a finding.
#
#Fix Text: Change the mode of the TFTP daemon.
#
#Procedure:
# chmod 0755 <in.tftpd binary>   
#######################DISA INFORMATION###############################

#Global Variables#
#PDI=GEN005100

#Start-Lockdown
# if [ -a "/usr/sbin/in.tftpd" ]; then
# echo '==================================================='
# echo ' Patching GEN005100 see RHEL-06-000222
# echo '==================================================='

    #ull the actual permissions
    # FILEPERMS=`stat -L --format='%04a' /usr/sbin/in.tftpd`

    #reak the actual file octal permissions up per entity
    # FILESPECIAL=${FILEPERMS:0:1}
    # FILEOWNER=${FILEPERMS:1:1}
    # FILEGROUP=${FILEPERMS:2:1}
    # FILEOTHER=${FILEPERMS:3:1}

   #Run check by 'and'ing the unwanted mask(7022)
    # if [ $(($FILESPECIAL&7)) != "0" ] || [ $(($FILEOWNER&0)) != "0" ] || [ $(($FILEGROUP&2)) != "0" ] || [ $(($FILEOTHER&2)) != "0" ]; then
        # chmod u-s,g-ws,o-wt /usr/sbin/in.tftpd
    # fi
# fi
