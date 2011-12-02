#!/bin/sh

PROFILE=$1
if [ -z $PROFILE ]; then
	echo "Invalid usage"
	exit
fi

echo `/usr/bin/security 2>&1 >/dev/null find-generic-password -gs "Mutt Password" -a $PROFILE | ruby -e 'print $1 if STDIN.gets =~ /^password: \"(.*)\"$/'`
