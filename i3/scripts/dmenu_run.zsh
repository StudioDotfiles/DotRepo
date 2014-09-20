#!/bin/zsh

# looks nice, but is slow
#exe=`dmenu_path | dmenu -b -i -fn '-*-*-medium-*-*-*-15-*-*-*-*-*-*-*' -nb \#3F3F3F -nf \#FAFAD2 -sb \#ffff00 -sf \#000000 ${1+"$@"}` && exec $exe

#has too many entries, like sed
exe=`dmenu_path | dmenu -b -i -nb \#3F3F3F -nf \#FAFAD2 -sb \#ffff00 -sf \#000000 ${1+"$@"}` && exec $exe

#has too few entries, for example xkill is missing, and uses unfamiliar names sometimes, baobab is called "disk usage analiser"
#j4-dmenu-desktop -d "dmenu -b -i -nb \#3F3F3F -nf \#FAFAD2 -sb \#ffff00 -sf \#000000 ${1+"$@"}"


#two alternatives that sort programs in order of usage:
#http://dmwit.com/yeganesh/
#http://space.rexroof.com/dmenu_run.pl.txt


#too slow
#exe=`~/.cabal/bin/yeganesh -x -- -b -i -nb \#3F3F3F -nf \#FAFAD2 -sb \#ffff00 -sf \#000000 ${1+"$@"}` && exec $exe
