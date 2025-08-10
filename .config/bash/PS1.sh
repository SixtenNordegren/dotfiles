#!/bin/sh

if tput setaf 1 >/dev/null 2>&1; then
	C_BLUE=$(tput setaf 4)
	C_GREEN=$(tput setaf 2)
	C_YELLOW=$(tput setaf 3)
	C_RED=$(tput setaf 1)
	C_CYAN=$(tput setaf 6)
	C_RESET=$(tput sgr0)
else
	C_BLUE='\033[0;34m'
	C_GREEN='\033[0;32m'
	C_YELLOW='\033[0;33m'
	C_RED='\033[0;31m'
	C_CYAN='\033[0;36m'
	C_RESET='\033[0m'
fi

PS1="\n\[${C_CYAN}\]\u@\h\[${C_RESET}\]:\[${C_YELLOW}\]\w"
PS1+="\$(__git_ps1 \" \[${C_GREEN}\](%s)\")\n"
PS1+="\$(if [ \$? != 0 ]; then echo \"\[${C_RED}\](\$?)\"; fi) "
PS1+="\[${C_RESET}\]\\$ "
