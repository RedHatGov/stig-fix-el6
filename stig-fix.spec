# STIG-FIX SPEC FILE
# License: GPL (see COPYING)
# Copyright: Red Hat Consulting, Aug 2014
# Author: Frank Caviggia <fcaviggi (at) redhat.com>

########################################
# Global Definitions
########################################

%define DATE		/bin/date +\%s
%define HDATE		/bin/date -Iminute
%define SCRIPT_NAME	stig-fix
%define PKG_VERSION	1.8.1
%define PKG_RELEASE	el6

%define BASE_DIR	/opt/%{SCRIPT_NAME}
%define BASE_BIN	%{BASE_DIR}
%define BASE_CONFIG	%{BASE_DIR}/config
%define BASE_BACKUP	%{BASE_DIR}/backups/
%define BASE_LOGDIR	/var/log
%define SCRIPT  	%{BASE_BIN}/apply.sh
%define LOGFILE		%{BASE_LOGDIR}/%{SCRIPT_NAME}.log

########################################
# RPM Spec File
########################################
Name:           %{SCRIPT_NAME}
Version:        %{PKG_VERSION}
Release:        %{PKG_RELEASE}
Vendor:		Red Hat
Distribution:	Red Hat Enterprise Linux
Packager:	fcaviggi@redhat.com
Summary:        RHEL 6 Hardening Scripts
Group:          Applications/System
License:        2013, GPL
URL:            http://www.redhat.com/
Source0:        %{name}-%{version}.tar.gz
BuildRoot:      %{_tmppath}/%{name}-%{version}-%{release}-%(%{__id_u} -n)
BuildArch:      noarch

#BuildRequires:  
Requires:	logwatch
Requires:	scrub
Requires:	aide
Requires:	vlock
Requires:	screen
Requires:	ntp
Requires:	openswan
Requires:	rsyslog
#Obsoletes:	
#Conflicts:

%description
RHEL 6 Hardening Script - Applies DISA UNIX STIG/NIST 800-53/NSA SNAC policies to system in order to automate DIACAP/ICD503 C&A/A&A process. 

%prep
%setup -q

%build

%install
%{__make} INSTROOT=${RPM_BUILD_ROOT} install

%clean
rm -rf ${RPM_BUILD_ROOT}

%pre

%post
###------------------------- Common Definitions ----------------------------###
DATE=`%{DATE}`
HDATE=`%{HDATE}`
NAME=%{SCRIPT_NAME}

# INSTALL RPM
if [ $1 -eq 1 ]; then
    if [ ! -d %{BASE_DIR} ]; then
        mkdir -p %{BASE_DIR} 
    fi

    if [ ! -d %{BASE_CONFIG} ]; then
        mkdir -p %{BASE_CONFIG}
    fi
	
    if [ ! -d %{BASE_BACKUP} ]; then
        mkdir -p %{BASE_BACKUP}
    fi

    touch %{LOGFILE}
    echo -n "Installing ${NAME} RPM: " >> %{LOGFILE} 2>&1
    echo ${HDATE} >> %{LOGFILE}
    ln -sf %{BASE_BIN}/apply.sh /sbin/stig-fix
    ln -sf %{BASE_BIN}/checkpoint.sh /sbin/stig-fix-checkpoint
    ln -sf %{BASE_BIN}/toggle_ipv6.sh /sbin/toggle_ipv6
    ln -sf %{BASE_BIN}/toggle_usb.sh /sbin/toggle_usb
    ln -sf %{BASE_BIN}/toggle_udf.sh /sbin/toggle_udf
    ln -sf %{BASE_BIN}/toggle_nousb.sh /sbin/toggle_nousb
fi

# UPGRADE RPM
if [ $1 -gt 1  ]; then
    echo -n "Upgrading ${NAME} RPM: " >> %{LOGFILE} 2>&1
    echo ${HDATE} >> %{LOGFILE}

    if [ ! -L /sbin/stig-fix ]; then
	ln -sf %{BASE_BIN}/apply.sh /sbin/stig-fix
    fi

    if [ ! -L /sbin/stig-fix-checkpoint ]; then
        ln -sf %{BASE_BIN}/checkpoint.sh /sbin/stig-fix-checkpoint
    fi

    if [ ! -L /sbin/toggle_ipv6 ]; then
	ln -sf %{BASE_BIN}/toggle_ipv6.sh /sbin/toggle_ipv6
    fi

    if [ ! -L /sbin/toggle_usb ]; then
	ln -sf %{BASE_BIN}/toggle_usb.sh /sbin/toggle_usb
    fi

    if [ ! -L  /sbin/toggle_udf ]; then
    	ln -sf %{BASE_BIN}/toggle_udf.sh /sbin/toggle_udf
    fi

    if [ ! -L  /sbin/toggle_nousb ]; then
    	ln -sf %{BASE_BIN}/toggle_nousb.sh /sbin/toggle_nousb
    fi
fi

%preun
###------------------------- Common Definitions ----------------------------###
DATE=`%{DATE}`
HDATE=`%{HDATE}`
KERNEL=`uname -r`
KERNEL_MODULE="/lib/modules/${KERNEL}/kernel/drivers/usb/storage/usb-storage.ko"
NAME=%{SCRIPT_NAME}

# REMOVE RPM
if [ $1 -eq 0 ]; then
    echo -n "Removing ${NAME} RPM: " >> %{LOGFILE} 2>&1
    echo ${HDATE} >> %{LOGFILE} 2>&1

    # RESTORE ORIGINAL CONFIGURATIONS
    cp %{BASE_BACKUP}/sysctl.conf.orig /etc/sysctl.conf
    cp %{BASE_BACKUP}/login.defs.orig /etc/login.defs
    cp %{BASE_BACKUP}/audit.rules.orig /etc/audit/audit.rules
    cp %{BASE_BACKUP}/auditd.conf.orig /etc/audit/auditd.conf
    cp %{BASE_BACKUP}/limits.conf.orig /etc/security/limits.conf
    cp %{BASE_BACKUP}/sshd_config.orig /etc/ssh/sshd_config
    cp %{BASE_BACKUP}/ssh_config.orig /etc/ssh/ssh_config
    cp %{BASE_BACKUP}/smb.conf.orig /etc/samba/smb.conf
    cp %{BASE_BACKUP}/sudoers.orig /etc/sudoers
    cp %{BASE_BACKUP}/system-auth.pam.orig /etc/pam.d/system-auth
    cp %{BASE_BACKUP}/password-auth.pam.orig /etc/pam.d/password-auth
    cp %{BASE_BACKUP}/gnome-screensaver.orig /etc/pam.d/gnome-screensaver
    cp %{BASE_BACKUP}/hosts.allow.orig /etc/hosts.allow
    cp %{BASE_BACKUP}/hosts.deny.orig /etc/hosts.deny
    cp %{BASE_BACKUP}/ntp.conf.orig /etc/ntp.conf
    cp %{BASE_BACKUP}/iptables.orig /etc/sysconfig/iptables
    cp %{BASE_BACKUP}/ip6tables.orig /etc/sysconfig/ip6tables
    restorecon -R /etc

    if [ ! -e ${KERNEL_MODULE} ]; then
	cp %{BASE_BACKUP}/usb-storage.ko.${KERNEL} ${KERNEL_MODULE}
    fi

    rm -f /etc/modprobe.d/usgcb-blacklist.conf
    rm -f /etc/profile.d/autologout*
    rm -f /sbin/%{SCRIPT_NAME}
    rm -f /sbin/stig-fix-checkpoint
    rm -f /sbin/toggle_usb
    rm -f /sbin/toggle_udf
    rm -f /sbin/toggle_nousb
    rm -f /sbin/toggle_ipv6
fi

# UPGRADE REMOVE RPM
#if [ $1 -gt 0 ]; then
#    echo -n "Upgrading ${NAME} RPM: " >> %{LOGFILE} 2>&1
#    echo ${HDATE} >> %{LOGFILE} 2>&1
#fi

%postun
###------------------------- Common Definitions ----------------------------###
DATE=`%{DATE}`
HDATE=`%{HDATE}`
NAME=%{SCRIPT_NAME}

# REMOVE RPM
if [ $1 -eq 0 ]; then
	rm -rf %{BASE_BACKUP}
	rm -rf %{BASE_CONFIG} 
	if [ -e %{LOGFILE} ]; then 
        	echo -n "Removed ${NAME} RPM: " >> %{LOGFILE} 2>&1
		echo ${HDATE} >> %{LOGFILE} 2>&1
		mv -f %{LOGFILE} %{LOGFILE}.${HDATE} ;
    	fi

fi

# UPGRADE REMOVE RPM
#if [ $1 -gt 0 ]; then
#    echo -n "Upgrading ${NAME} RPM: " >> %{LOGFILE} 2>&1
#    echo ${HDATE} >> %{LOGFILE} 2>&1
#fi

%files
%defattr(-,root,root,-)
%attr(0700,root,root) %{BASE_BIN}/*
%attr(0600,root,root) %{BASE_CONFIG}/*

%doc README COPYING AUTHORS CHANGELOG
%doc stig-fix.spec stig-fix-vms.xml
