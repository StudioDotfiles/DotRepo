# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#ZSH_THEME="random"
#ZSH_THEME="budspencer"
#ZSH_THEME="robbyrussell"
#ZSH_THEME="avit"
#ZSH_THEME="risto"
ZSH_THEME="juanghurtadoVI"
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
 DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"


# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)

#plugins=(command-not-found debian git history-substring-search zsh-syntax-highlighting vi-mode)
#
#vi-mode needs to be before history-substring-search
plugins=(vi-mode command-not-found debian git history-substring-search zsh-syntax-highlighting compleat dircycle extract fasd taskwarrior colored-man)
#compleat

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export PATH=/usr/local/bin:/usr/bin:/bin:/usr/bin/X11:/usr/games
export EDITOR="$(if [[ -n $DISPLAY ]]; then echo 'gvim'; else echo 'vim'; fi)"
alias mn='/bin/findmnt -rnuc -o SOURCE,TARGET,FSTYPE,OPTIONS | sort | column -t'
alias gv='gvim'

#might mess with GhostScript:
alias gs='git status'

#
# Sets history options.
#
# Authors:
# Robby Russell <robby@planetargon.com>
# Sorin Ionescu <sorin.ionescu@gmail.com>
#
#HISTFILE="$HOME/.zhistory"
HISTSIZE=10000000
SAVEHIST=10000000
setopt BANG_HIST # Treat the '!' character specially during expansion.
#setopt EXTENDED_HISTORY # Write the history file in the ":start:elapsed;command" format.
setopt INC_APPEND_HISTORY # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS # Do not display a line previously found.
setopt HIST_IGNORE_SPACE # Don't record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS # Remove superfluous blanks before recording entry.
setopt HIST_VERIFY # Don't execute immediately upon history expansion.
setopt HIST_BEEP # Beep when accessing nonexistent history.alias fl='FaustLive'


##################################################################
# change cursor color in vi-mode
##################################################################
bindkey -v
zle-keymap-select () {
  if [ $TERM = "screen" ]; then
    if [ $KEYMAP = vicmd ]; then
      echo -ne '\033P\033]12;#ff6565\007\033\\'
    else
      echo -ne '\033P\033]12;grey\007\033\\'
    fi
  elif [ $TERM != "linux" ]; then
    if [ $KEYMAP = vicmd ]; then
      echo -ne "\033]12;#ff6565\007"
    else
      echo -ne "\033]12;grey\007"
    fi
  fi
}; zle -N zle-keymap-select
zle-line-init () {
  zle -K viins
  if [ $TERM = "screen" ]; then
    echo -ne '\033P\033]12;grey\007\033\\'
  elif [ $TERM != "linux" ]; then
    echo -ne "\033]12;grey\007"
  fi
}; zle -N zle-line-init
