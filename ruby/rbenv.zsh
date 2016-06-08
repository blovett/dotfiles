if [[ -x "$HOME/.rbenv/bin/rbenv" ]]; then
	export PATH="$HOME/.rbenv/bin:$PATH"
fi
if which rbenv >/dev/null; then
	eval "$(rbenv init -)"
fi
