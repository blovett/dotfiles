export PAGER=less
export LESS="-cex3MR"
if (( $+commands[vim] )); then
	export EDITOR=vim
fi
