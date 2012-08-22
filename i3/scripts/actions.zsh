#!/bin/zsh -f

#

cd ~/.config/i3/scripts/actions/
		actions=(*(x))
		if [[ "$2" = '~~' ]]; then
			do=$(dmenu $actions)
		elif [[ -n "$2" ]]; then
			do="$2 "
			shift 2
			do+=$*
		else
			do=$(print -l $actions | dmenu -b -i -fn '-*-*-medium-*-*-*-15-*-*-*-*-*-*-*' -nb \#3F3F3F -nf \#FAFAD2 -sb \#ffff00 -sf \#000000 -p Actions:)
		fi
		eval $PWD/$do &!
