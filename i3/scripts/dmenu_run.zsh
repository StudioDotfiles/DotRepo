#!/bin/zsh
exe=`dmenu_path | dmenu -b -i -fn '-*-*-medium-*-*-*-15-*-*-*-*-*-*-*' -nb \#3F3F3F -nf \#FAFAD2 -sb \#ffff00 -sf \#000000 ${1+"$@"}` && exec $exe
