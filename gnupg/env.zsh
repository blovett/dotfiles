export GPG_TTY="$(tty)"
eval "$(gpg-agent --daemon 2>/dev/null)"
unset SSH_AGENT_PID
if [[ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]]; then
	export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
fi

