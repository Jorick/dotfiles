# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -v
# path for custom zsh stuff
fpath=( "$HOME/.zshfunctions" $fpath )

# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/jorick/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
#
# autoload zsh stuff
# 
# Base 16 shell color scheme
#BASE16_SHELL="$HOME/.config/base16-shell/base16-monokai.dark.sh"
#[[ -s $BASE16_SHELL ]] && source $BASE16_SHELL ]
##################
# PURE zsh theme #
##################
autoload -U promptinit && promptinit

# pure options
PURE_CMD_MAX_EXEC_TIME=60
PURE_PROMPT_SYMBOL=">>>"

# load pure
prompt pure

autoload -U colors && colors
# zsh options
setopt nohashdirs
unsetopt correct_all
setopt correct

zstyle ':completion:*' menu select
zstyle ':completion:*' rehash true

setopt completealiases

# Stuff transfered from .bashrc
xhost +local:root > /dev/null 2>&1

export HISTCONTROL=ignoreboth
export EDITOR="nvim"
# set colors for ls
eval $(dircolors ~/.dircolors)

# set aliasses
alias ls='ls --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F'
alias ll='ls -l --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F'
alias la='ls -la --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F'
alias grep='grep --color=tty -d skip'
alias cp="cp -i"                          # confirm before overwriting something
alias df='df -h'                          # human-readable sizes
alias free='free -m'                      # show sizes in MB
# editor
alias v='nvim'
# Pacman aliasses
alias ipac='sudo pacman -S'
alias spac='pacman -Ss'
alias upac='sudo pacman -Syu'
# Packer aliasses
#alias packer='packer-color'
alias upacaur='packer-color -Su --auronly'
# various aliasses
alias google-chrome='google-chrome-stable'
alias um='udiskie-umount'
alias ssh-pi='ssh -p 50299 192.168.0.128'
alias screensaver-off='xset -dpms && xset s off'
alias screensaver-on='xset +dpms && xset s on'
alias mirror-update='sudo reflector -p https -l 100 -f 10 --sort score --save /etc/pacman.d/mirrorlist'
# Reddit cli app
alias rtv='rtv -u Vargman'
# Copy and paste to/from clipboard
alias pbcopy='xsel --clipboard --input'
alias pbpaste='xsel --clipboard --output'
# Crazy hacking stuff
alias haxor='cat /dev/urandom | hexdump -C | grep "ca fe"'
#alias twitter='twitter --format ansi'

# ex - archive extractor
# usage: ex <file>
ex ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1     ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# Path for own scripts
export PATH=$PATH:$HOME/bin
export PATH=$PATH:$HOME/.config/bspwm/panel
# prompt
#PS1=' \e[0;34m\u \e[0m@ \h \w \n\$ '
#PS1="%F{blue}%n%f @ %m %~
#%# %F{blue}>>>%f "
BROWSER=/usr/bin/firefox

# Variables to run bar with bspwm

# Add Fish like syntac highlighting
# requires zsh-syntax-highlighting
source $HOME/github/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
#source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
