alias reload!='. ~/.zshrc'
if (( $+commands[vim] )); then
	alias vi='vim'
fi

# Global aliases (don't need to be at the beginning of the command line)
alias -g L='|less'
alias -g H='|head'
alias -g T='|tail'
