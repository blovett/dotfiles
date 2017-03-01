if [[ -f "${HOME}/.gpg-agent-info" ]]; then
	. "${HOME}/.gpg-agent-info"
fi

if [[ -S "${GPG_AGENT_INFO%%:*}" ]]; then
	export GPG_AGENT_INFO
else
	eval $( gpg-agent --daemon --write-env-file "${HOME}/.gpg-agent-info" )
fi
