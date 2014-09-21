# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="risto"

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

