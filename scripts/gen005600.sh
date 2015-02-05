#!/bin/bash

## (GEN005600: CAT II) The SA will ensure IP forwarding is disabled if the 
## system is not dedicated as a router.
echo '==================================================='
echo ' Patching GEN005600: Disable IP forwarding'
echo '==================================================='
sed -i "/net\.ipv4\.ip_forward/ c\
net.ipv4.ip_forward = 0" /etc/sysctl.conf
