#!/bin/bash

## (GEN000500: CAT II) (Previously – G605) The SA will configure systems to log
## out interactive processes (i.e., terminal sessions, ssh sessions, etc.,) 
## after 15 minutes of inactivity or ensure a password protected screen lock 
## mechanism is used and is set to lock the screen after 15 minutes of 
## inactivity.
echo '==================================================='
echo ' Patching GEN000500: Set inactive shell timeout'
echo '==================================================='

cat <<EOF > /etc/profile.d/autologout.sh
#!/bin/sh
TMOUT=900
readonly TMOUT
export TMOUT
EOF

cat <<EOF > /etc/profile.d/autologout.csh
#!/bin/csh
set autologout=15
set -r autologout
EOF

chown root:root /etc/profile.d/autologout.sh
chown root:root /etc/profile.d/autologout.csh
chmod 755 /etc/profile.d/autologout.sh
chmod 755 /etc/profile.d/autologout.csh
