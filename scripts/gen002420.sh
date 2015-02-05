#!/bin/bash

#######################DISA INFORMATION###############################
##
## (GEN002420: CAT II) (Previously – G086) The SA will ensure user filesystems,
## removable media, and remote filesystems will be mounted with the nosuid
## option.
##
## (GEN002430: CAT II)  Removable media, remote file systems, and any file 
## system that does not contain approved device files must be mounted with 
## the "nodev" option.
##
#######################DISA INFORMATION###############################

echo '==================================================='
echo ' Patching GEN002420: Mount filesystems with nosuid'
echo '==================================================='
echo '==================================================='
echo ' Patching GEN002430: Mount filesystems with nodev'
echo '==================================================='

FSTAB=/etc/fstab
SED=`which sed`

    #nosuid on /sys
    if [ $(grep " \/sys " ${FSTAB} | grep -c "nosuid") -eq 0 ]; then
            MNT_OPTS=$(grep " \/sys " ${FSTAB} | awk '{print $4}')
            ${SED} -i "s/\( \/sys.*${MNT_OPTS}\)/\1,nosuid/" ${FSTAB}
    fi

    #nodev,nosuid on /boot
    if [ $(grep " \/boot " ${FSTAB} | grep -c "nosuid") -eq 0 ]; then
            MNT_OPTS=$(grep " \/boot " ${FSTAB} | awk '{print $4}')
            ${SED} -i "s/\( \/boot.*${MNT_OPTS}\)/\1,nodev,nosuid/" ${FSTAB}
    fi

    #nodev and nosuid on /usr
    if [ $(grep " \/usr " ${FSTAB} | grep -c "nodev") -eq 0 ]; then
            MNT_OPTS=$(grep " \/usr " ${FSTAB} | awk '{print $4}')
            ${SED} -i "s/\( \/usr .*${MNT_OPTS}\)/\1,nodev,nosuid/" ${FSTAB}
    fi

    #nodev and nosuid on /home
    if [ $(grep " \/home " ${FSTAB} | grep -c "nodev") -eq 0 ]; then
            MNT_OPTS=$(grep " \/home " ${FSTAB} | awk '{print $4}')
            ${SED} -i "s/\( \/home .*${MNT_OPTS}\)/\1,nodev,nosuid/" ${FSTAB}
    fi

    #nodev and nosuid on /export/home
    if [ $(grep " \/export\/home " ${FSTAB} | grep -c "nodev") -eq 0 ]; then
            MNT_OPTS=$(grep " \/export\/home " ${FSTAB} | awk '{print $4}')
            ${SED} -i "s/\( \/export\/home .*${MNT_OPTS}\)/\1,nodev,nosuid/" ${FSTAB}
    fi

    #nodev and nosuid on /usr/local
    if [ $(grep " \/usr\/local " ${FSTAB} | grep -c "nodev") -eq 0 ]; then
            MNT_OPTS=$(grep " \/usr\/local " ${FSTAB} | awk '{print $4}')
            ${SED} -i "s/\( \/usr\/local.*${MNT_OPTS}\)/\1,nodev,nosuid/" ${FSTAB}
    fi

    #nodev,noexec,nosuid on /dev/shm
    if [ $(grep " \/dev\/shm " ${FSTAB} | grep -c "nodev") -eq 0 ]; then
            MNT_OPTS=$(grep " \/dev\/shm " ${FSTAB} | awk '{print $4}')
            ${SED} -i "s/\( \/dev\/shm.*${MNT_OPTS}\)/\1,nodev,noexec,nosuid/" ${FSTAB}
    fi

    #nodev,noexec,nosuid on /tmp
    if [ $(grep " \/tmp " ${FSTAB} | grep -c "nodev") -eq 0 ]; then
            MNT_OPTS=$(grep " \/tmp " ${FSTAB} | awk '{print $4}')
            ${SED} -i "s/\( \/tmp.*${MNT_OPTS}\)/\1,nodev,noexec,nosuid/" ${FSTAB}
    fi

    #nodev,noexec,nosuid on /var/tmp
    if [ $(grep " \/var\/tmp " ${FSTAB} | grep -c "nodev") -eq 0 ]; then
            MNT_OPTS=$(grep " \/var\/tmp " ${FSTAB} | awk '{print $4}')
            ${SED} -i "s/\( \/var\/tmp.*${MNT_OPTS}\)/\1,nodev,noexec,nosuid/" ${FSTAB}
    fi
    
     #nodev,noexec,nosuid on /var/log
    if [ $(grep " \/var\/log " ${FSTAB} | grep -c "nodev") -eq 0 ]; then
            MNT_OPTS=$(grep " \/var\/tmp " ${FSTAB} | awk '{print $4}')
            ${SED} -i "s/\( \/var\/tmp.*${MNT_OPTS}\)/\1,nodev,noexec,nosuid/" ${FSTAB}
    fi

    #nodev,noexec,nosuid on /var/audit
    if [ $(grep " \/var\/log\/audit " ${FSTAB} | grep -c "nodev") -eq 0 ]; then
            MNT_OPTS=$(grep " \/var\/log\/audit " ${FSTAB} | awk '{print $4}')
            ${SED} -i "s/\( \/var\/log\/audit.*${MNT_OPTS}\)/\1,nodev,noexec,nosuid/" ${FSTAB}
    fi

    #nodev,nosuid on /var/
    if [ $(grep " \/var " ${FSTAB} | grep -c "nodev") -eq 0 ]; then
            MNT_OPTS=$(grep " \/var " ${FSTAB} | awk '{print $4}')
            ${SED} -i "s/\( \/var.*${MNT_OPTS}\)/\1,nodev,nosuid/" ${FSTAB}
    fi
