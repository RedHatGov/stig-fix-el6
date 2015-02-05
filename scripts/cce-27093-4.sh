#!/bin/bash

echo '==================================================='
echo ' CCE-27093-4: Enable NTP Service'
echo '==================================================='

# CCE-27093-4: Enable NTP
chkconfig ntpd on
