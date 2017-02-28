if ! pgrep gpg-agent >/dev/null; then
	gpg --card-status >/dev/null
fi
if [ -f "${HOME}/.gpg-agent-info" ]; then
	. "${HOME}/.gpg-agent-info"
	export GPG_AGENT_INFO
	export SSH_AUTH_SOCK
	export GPG_TTY="$(tty)"
fi
