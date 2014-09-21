#!/bin/zsh

#for now, half the work is being done in ~/.i3/config
export NSM_URL=osc.udp://WheezyOne.lbb:17552
#exec nsmd --osc-port 17552

#solarize everything!
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources


exec i3



