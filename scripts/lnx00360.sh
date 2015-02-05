#!/bin/bash

## (LNX00360: CAT II) (Previously – L032) The SA will enable the X server 
## –audit (at level 4) and –s option (with 15 minutes as the timeout time) 
## options.
echo '==================================================='
echo ' Patching LNX00360: Set X server options'
echo '==================================================='
grep -q Standard /etc/gdm/custom.conf &>/dev/null
	if [ $? -ne 0 ]; then
		cat >> /etc/gdm/custom.conf << EOF

[server-Standard]
name=Standard server
command=/usr/bin/Xorg -br -audit 4 -s 15
flexible=true
EOF
fi
