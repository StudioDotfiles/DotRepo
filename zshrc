# Set up the prompt

autoload -Uz promptinit
promptinit
prompt adam1

setopt histignorealldups sharehistory

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# Use modern completion system
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# zshrun A lightweight, one-off application launcher {{{1
# by Mikael Magnusson (I think)
#
# To run a command without closing the dialog press ctrl-j instead of enter
# Invoke like:
# sh -c 'ZSHRUN=1 rxvt -name zshrun -geometry 100x8+200+300 +ls'
# The -name is so that wmii can make it float

if [[ -n "$ZSHRUN" ]]; then
    unset ZSHRUN
    function _accept_and_quit1() {
        zsh -c "${BUFFER}" &|
        exit
    }
    function _cancel_zshrun() {
        exit
    }
    zle -N _accept_and_quit1
    bindkey "^M" _accept_and_quit1
	bindkey "^Z" _cancel_zshrun
    PROMPT="zshrun %~> "
    RPROMPT=""
fi

########################################################################
# aliases
########################################################################

#always use ls with color
alias ls='ls -F --group-directories-first -h --color'

#todo:fix
#colors for dmenu
#alias dmenu='dmenu -b -i -nb \#DCDAD5 -nf \#3F3F3F -sb \#ffff00 -sf \#000000'
