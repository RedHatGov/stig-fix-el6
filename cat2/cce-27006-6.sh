#!/bin/bash

## CCE-27006-6, enable ip6tables if ip6 enabled

echo '==================================================='
echo ' Enable ip6tables if IPv6 enabled in kernel'
echo '==================================================='
chkconfig ip6tables on
service ip6tables start
