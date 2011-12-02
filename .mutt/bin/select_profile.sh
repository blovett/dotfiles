#!/bin/bash

# Select a mail profile for mutt.

BASEDIR=~/.mutt/profiles/
MUTTPROFILE=${BASEDIR}/active.profile
CHOICE=`mktemp /tmp/mp.XXXXXX`

declare menulist

for option in `find ${BASEDIR} -name "*.profile" -type f | xargs -n 1 -I X basename X .profile`; do
	menulist[${#menulist[@]}]="$option"
	desc=`grep "DESC:" $BASEDIR/$option.profile`
	menulist[${#menulist[@]}]="${desc/*DESC: /}"
done

#printf "${menulist[*]}"
#exit

IFS=$'\n'
default=`find ${BASEDIR} -name "*.profile" -type l -exec readlink {} \; | xargs -n 1 -I X basename X .profile`
dialog --default-item $default --nocancel --menu "Profile Selection" 20 60 10 $(printf "${menulist[*]}") 2> $CHOICE
ret=$(cat $CHOICE)
rm -f $CHOICE
if [ -f ${BASEDIR}/${ret}.profile ]; then
	ln -sf ${BASEDIR}/${ret}.profile $MUTTPROFILE
fi
