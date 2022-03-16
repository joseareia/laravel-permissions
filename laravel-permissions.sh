#!/bin/bash

# Text formatting
bold=$(tput bold)
normal=$(tput sgr0)

# Flag arguments
wflag=
pflag=

exit_abnormal() {
    echo -e "Usage: ${0##*/} [-w USER] [-p PATH]"
}

show_help() {
	echo -e "Laravel Permissions - Set up permissions for your Laravel projects."
	echo -e "Usage: ${0##*/} [-w USER] [-p PATH]\n"
	echo -e "\t-h\tshow brief help"
	echo -e "\t-w\twebserver as owner of the project - must specify the user (${bold}OPTIONAL${normal})"
	echo -e "\t-p\tspecify the directory of the project (${bold}OPTIONAL${normal})"
    echo -e "\n${bold}NOTE:${normal} If -w is not used, the project owner will be the current user."
	echo -e "${bold}NOTE:${normal} If -p is not used, the script will run in the current directory."
}

while getopts 'hw:user:p:path' opt; do
    case $opt in
        h)
			show_help
        	exit 0
			;;
		w)
			wflag=1
            user="${OPTARG}"
			;;
		p)
			pflag=1
			path="${OPTARG}"
			;;
		*)
			exit_abnormal >&2
			exit 1
			;;
  esac
done

shift $(($OPTIND - 1))

if [ ! -z "$pflag" ] && [ ! -d "$path" ]; then
    echo -e "The following directory does not exist: $path"
    exit_abnormal >&2
    exit 1
fi

if [ ! -z "$wflag" ]; then
    if [ ! -z "$pflag" ]; then
        sudo chown -R www-data:www-data $path
        sudo find $path -type f -exec chmod 644 {} \;
        sudo find $path -type d -exec chmod 755 {} \;
    else
        sudo chown -R www-data:www-data .
        sudo find . -type f -exec chmod 644 {} \;
        sudo find . -type d -exec chmod 755 {} \;
    fi
    sudo usermod -a -G www-data $user
else
    if [ ! -z "$pflag" ]; then
        sudo chown -R $USER:www-data $path
        sudo find $path -type f -exec chmod 664 {} \;
        sudo find $path -type d -exec chmod 775 {} \;
    else
        sudo chown -R $USER:www-data .
        sudo find . -type f -exec chmod 664 {} \;
        sudo find . -type d -exec chmod 775 {} \;
    fi
fi
echo -e "Changing owner permissions..."
echo -e "Changing mode permissions..."

# Give the webserver the rights to read and write to storage and cache
# Note: This may depend on your situation, if so, edit.
if [ ! -z "$pflag" ]; then
    sudo chgrp -R www-data $path/storage $path/bootstrap/cache
    sudo chmod -R ug+rwx $path/storage $path/bootstrap/cache
else
    sudo chgrp -R www-data storage bootstrap/cache
    sudo chmod -R ug+rwx storage bootstrap/cache
fi
echo -e "Changing cache and storage permissions..."

echo -e "[SUCCESS] Permissions were changed. All set up."
