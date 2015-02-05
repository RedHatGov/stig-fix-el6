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
# on 05-Feb-2012 to fix a couple of bugs in the mask checking, simplify and
# speed up the whole check.


#######################DISA INFORMATION###############################
#Group ID (Vulid): V-12014
#Group Title: .Xauthority File Permissions
#Rule ID: SV-12515r5_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN005180
#Rule Title: All .Xauthority files must have mode 0600 or less permissive.
#
#Vulnerability Discussion: .Xauthority files ensure that the user is authorized to access that specific X Windows host. Excessive permissions may permit unauthorized modification of these files, which could lead to denial of service to authorized access or allow unauthorized access to be obtained.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Check the file permissions for the .Xauthority files.
#
#Procedure:
# ls -la |egrep "(\.Xauthority|\.xauth)"
#
#If the file mode is more permissive than 0600, this is finding.
#
#Fix Text: Change the mode of the .Xauthority files.
#
#Procedure:
# chmod 0600 .Xauthority   
#######################DISA INFORMATION###############################

echo '==================================================='
echo ' Patching GEN001900: .Xauthority File Permissions'
echo '==================================================='

#Global Variables#
PDI=GEN005180

#Start-Lockdown
find / -name *.xauth -o -name *.Xauthority -perm /7177 -exec chmod u-xs,g-rwxs,o-rwxt {} \;

