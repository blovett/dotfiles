function title() {
	case $TERM in
		xterm*)
			print -Pn "\033]0;%m:%~\007"
			;;
	esac
}
