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
# on 14-Feb-2012 to move from dev to prod and add fix.
#
#  - Updated by Shannon Mitchell(shannon.mitchell@fusiontechnology-llc.com)
# on 18-Feb-2012 to add an iptables rule check before adding the new rules.
# 
# - Updated by Luke Brisk(Luke.Brisk@Boeing.com or Luke.Brisk@gmail.com)
# on 27-Oct-2014 to comment out old Vulnerability mitigation for GEN006380
# and created new RHEL Script for RHEL-06-000220.

# *****Old GEN006380 Replaced by RHEL-06-000220***
# Group ID (Vulid):  V-38603
# Group Title:  SRG-OS-000095
# Rule ID:  SV-50404r1_rule
# Severity: CAT II
# Rule Version (STIG-ID):  RHEL-06-000220
# Rule Title: The ypserv package must not be installed.
#
#
# Vulnerability Discussion:  Removing the "ypserv" package decreases the risk of the accidental (or intentional) activation of NIS or NIS+ services.
#
# Check Content:  
# Run the following command to determine if the "ypserv" package is installed: 
#
#rpm -q ypserv
#
# If the package is installed, this is a finding.
#
# Fix Text: The "ypserv" package can be uninstalled with the following command: 
#
#yum erase ypserv   
#
# CCI: CCI-000381


#Global Variables#
# PDI=GEN006380

#Start-Lockdown

# There is no built in way to do this, so lets go with redhat's recommendations
# for securing NIS and set a static port.  udp can be blocked with iptables.

# rpm -q ypserv > /dev/null
# if [ $? -eq 0 ]; then
# echo '==================================================='
# echo ' Patching GEN006380: See RHEL-06-000220'
# echo '==================================================='

  # grep 'YPSERV_ARGS' /etc/sysconfig/network > /dev/null
  # if [ $? -eq 0 ]; then
    # grep 'YPSERV_ARGS' /etc/sysconfig/network | grep '\-p 834' > /dev/null
    # if [ $? -ne 0 ]; then
      # sed -i -e 's/YPSERV_ARGS.*/YPSERV_ARGS="-p 834"/g' /etc/sysconfig/network
    # fi
  # else
    # echo "# Setting static NIS port for STIG $PDI" >> /etc/sysconfig/network
    # echo 'YPSERV_ARGS="-p 834"' >> /etc/sysconfig/network
  # fi

  # grep 'YPXFRD_ARGS' /etc/sysconfig/network > /dev/null
  # if [ $? -eq 0 ]; then
    # grep 'YPXFRD_ARGS' /etc/sysconfig/network | grep '\-p 835' > /dev/null
    # if [ $? -ne 0 ]
    # then
      # sed -i -e 's/YPXFRD_ARGS.*/YPXFRD_ARGS="-p 835"/g' /etc/sysconfig/network
    # fi
  # else
    # echo "# Setting static NIS port for STIG $PDI" >> /etc/sysconfig/network
    # echo 'YPXFRD_ARGS="-p 835"' >> /etc/sysconfig/network
  # fi

  # grep 'INPUT \-p udp \-m udp \-\-dport 834 \-j DROP' /etc/sysconfig/iptables > /dev/null
  # if [ $? -ne 0 ]; then
    # service iptables start > /dev/null
    # iptables -I INPUT 1 -p udp -m udp --dport 834 -j DROP
    # service iptables save > /dev/null
  # fi

  # grep 'INPUT \-p udp \-m udp \-\-dport 835 \-j DROP' /etc/sysconfig/iptables > /dev/null
  # if [ $? -ne 0 ]; then
    # service iptables start > /dev/null
    # iptables -I INPUT 1 -p udp -m udp --dport 835 -j DROP
    # service iptables save > /dev/null
  # fi
  # service ypserv restart > /dev/null
# fi
