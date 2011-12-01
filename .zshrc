if [ -x /usr/libexec/path_helper ]; then
	eval `/usr/libexec/path_helper -s`
fi

set_my_prompt() {
	PROMPT="%m %~ %# "
}
set_my_prompt

# Aliases

# Global aliases (don't need to be at the beginning of the command line)
alias -g L='|less'
alias -g H='|head'
alias -g T='|tail'

alias rm='rm -i'
alias grep=egrep
alias ls='ls -F'
alias sha256='openssl dgst -sha256'

# automatically remove duplicates from these arrays
typeset -U path cdpath fpath manpath

# key bindings
bindkey -e			# emacs key bindings
bindkey ' ' magic-space		# do history expansion on space
bindkey '^I' complete-word	# complete on tab. leve expansion to _expand

# setup autocomplete
autoload -U compinit
compinit

# Completion Styles
# list of completers to use
zstyle ':completion:*::::' completer _expand _complete _ignored _approximate

# allow one error for every three characters typed in approximate completer
zstyle -e ':completion:*:approximate:*' max-errors \
    'reply=( $(( ($#PREFIX+$#SUFFIX)/3 )) numeric )'
    
# insert all expansions for expand completer
zstyle ':completion:*:expand:*' tag-order all-expansions

# formatting and messages
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'
zstyle ':completion:*' group-name ''

# match uppercase from lowercase
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# offer indexes before parameters in subscripts
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

# command for process lists, the local web server details and host completion
#zstyle ':completion:*:processes' command 'ps -o pid,s,nice,stime,args'
#zstyle ':completion:*:urls' local 'www' '/var/www/htdocs' 'public_html'
zstyle '*' hosts $hosts

# Filename suffixes to ignore during completion (except after rm command)
zstyle ':completion:*:*:(^rm):*:*files' ignored-patterns '*?.o' '*?.c~' \
    '*?.old' '*?.pro'
# the same for old style completion
#fignore=(.o .c~ .old .pro)

# ignore completion functions (until the _ignored completer)
zstyle ':completion:*:functions' ignored-patterns '_*'

set_window_title() {
	print -Pn "\033]0;%m:%~\007"
}
case $TERM in
	*xterm*)
	precmd() {
		set_window_title
	}
	;;
esac
