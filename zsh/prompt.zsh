autoload colors && colors
# cheers, @ehrenmurdick
# http://github.com/ehrenmurdick/config/blob/master/zsh/prompt.zsh

if (( $+commands[git] ))
then
  git="$commands[git]"
else
  git="/usr/bin/git"
fi

git_branch() {
  echo $($git symbolic-ref HEAD 2>/dev/null | awk -F/ {'print $NF'})
}

git_dirty() {
  st=$($git status 2>/dev/null | tail -n 1)
  if [[ $st == "" ]]
  then
    echo ""
  else
    if [[ "$st" =~ ^nothing ]]
    then
      echo " on %{$fg_bold[green]%}$(git_prompt_info)%{$reset_color%}"
    else
      echo " on %{$fg_bold[red]%}$(git_prompt_info)%{$reset_color%}"
    fi
  fi
}

git_prompt_info () {
 ref=$($git symbolic-ref HEAD 2>/dev/null) || return
# echo "(%{\e[0;33m%}${ref#refs/heads/}%{\e[0m%})"
 echo "${ref#refs/heads/}"
}

unpushed () {
  $git cherry -v @{upstream} 2>/dev/null
}

need_push () {
  if [[ $(unpushed) == "" ]]
  then
    echo " "
  else
    echo " with %{$fg_bold[magenta]%}unpushed%{$reset_color%} "
  fi
}

rb_prompt(){
  if (( $+commands[rbenv] ))
  then
	  echo "%{$fg_bold[yellow]%}$(rbenv version | awk '{print $1}')%{$reset_color%}"
	else
	  echo ""
  fi
}

# This keeps the number of todos always available the right hand side of my
# command line. I filter it to only count those tagged as "+next", so it's more
# of a motivation to clear out the list.
todo(){
  if (( $+commands[todo.sh] ))
  then
    num=$(echo $(todo.sh ls +next | wc -l))
    let todos=num-2
    if [ $todos != 0 ]
    then
      echo "$todos"
    else
      echo ""
    fi
  else
    echo ""
  fi
}

if [ -n "$SSH_CONNECTION" ]; then
  PROMPT='%m %55<...<%~$(git_dirty)$(need_push)$(vc_prompt_char)%# '
else
  PROMPT='%55<...<%~$(git_dirty)$(need_push)$(vc_prompt_char)%# '
fi

function vc_prompt_char() {
	git branch >/dev/null 2>/dev/null && echo '± ' && return
	svn info >/dev/null 2>/dev/null && echo 'δ ' && return
	#echo '○'
	echo ''
}

function battery_charge() {
	bclrf=/tmp/batcharge-last-run-$$

	[ ! -f $bclrf ] && date +%s > $bclrf
	LAST_RUN_TIME=$(< $bclrf)

	NOW=$(date +%s)
	DELTA=$(( $NOW - $LAST_RUN_TIME ))

	bcrf=/tmp/batcharge_results-$$
	if [ ! -f $bcrf ]; then
		$ZSH/bin/batcharge.py > $bcrf
	elif [ $DELTA -ge 120 ]; then
		$ZSH/bin/batcharge.py > $bcrf
		date +%s > $bclrf
	fi

	echo $(<$bcrf)
}

#OS=$(uname -s)
#if [ x"$OS" = x"Darwin" ]
#then
#	export RPROMPT='$(battery_charge)'
#fi

precmd() {
  title "zsh" "%m" "%55<...<%~"
}
