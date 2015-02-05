#!/bin/sh

echo '==================================================='
echo ' Checking CCE-26911-8: GRUB Password'
echo '==================================================='
`/bin/grep password /boot/grub/grub.conf | /bin/grep -q encrypted`
if [ $? -gt 0 ]; then
        tput setaf 1;echo -e "\033[1mWARNING! WARNING! WARNING! WARNING! WARNING!\033[0m";tput sgr0
        tput setaf 1;echo -e "\033[1mGRUB IS NOT PASSWORD PROTECTED!\033[0m";tput sgr0
	tput setaf 1;echo -e "\033[1mWARNING! WARNING! WARNING! WARNING! WARNING!\033[0m";tput sgr0
fi
