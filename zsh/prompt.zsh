autoload colors && colors
# cheers, @ehrenmurdick
# http://github.com/ehrenmurdick/config/blob/master/zsh/prompt.zsh

if (( $+commands[git] ))
then
  git="$commands[git]"
else
  git="/usr/bin/git"
fi

git_dirty() {
	if $( ! $git status -s &>/dev/null); then
		echo ""
	else
		if [[ $( $git status --porcelain --untracked-files=no ) == "" ]]; then
			echo " on %{$fg_bold[green]%}$(git_prompt_info)%{$reset_color%}"
		else
			echo " on %{$fg_bold[red]%}$(git_prompt_info)%{$reset_color%}"
		fi
	fi
}

git_prompt_info () {
 ref=$($git symbolic-ref HEAD 2>/dev/null) || return
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

PROMPT='%55<...<%~$(git_dirty)$(need_push)$(vc_prompt_char)%# '
if [ -n "$SSH_CONNECTION" ]; then
  PROMPT="%m ${PROMPT}"
fi

function vc_prompt_char() {
	git branch >/dev/null 2>/dev/null && echo '± ' && return
	svn info >/dev/null 2>/dev/null && echo 'δ ' && return
	#echo '○'
	echo ''
}

precmd() {
  title "zsh" "%m" "%55<...<%~"
}
