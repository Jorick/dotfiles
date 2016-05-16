#
#                   ██                    
#                  ░██                    
#    ██████  ██████░██      ██████  █████ 
#   ░░░░██  ██░░░░ ░██████ ░░██░░█ ██░░░██
#      ██  ░░█████ ░██░░░██ ░██ ░ ░██  ░░ 
# ██  ██    ░░░░░██░██  ░██ ░██   ░██   ██
#░██ ██████ ██████ ░██  ░██░███   ░░█████ 
#░░ ░░░░░░ ░░░░░░  ░░   ░░ ░░░     ░░░░░  
#
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -v

# define path for custom zsh functions and plugins
# contains:
# own plugins and function
# pure theme (symlinked symlinked from git source)
# zsh-syntax-highlighting (symlinked from git source)
export ZSHFUNC=/home/jorick/.zshfunctions
# add custom path to fpath
fpath=( "$ZSHFUNC" $fpath )

zstyle :compinstall filename '/home/jorick/.zshrc'
autoload -Uz compinit
compinit

# PURE zsh theme
# source and instructions see: https://github.com/sindresorhus/pure

autoload -U promptinit && promptinit

# pure options
PURE_CMD_MAX_EXEC_TIME=60
PURE_PROMPT_SYMBOL=">"
#
# load pure
prompt pure
autoload -U colors && colors

zstyle ':completion:*' menu select
zstyle ':completion:*' rehash true

# PLUGINS
# list plugins
plugins=(grml-comp update golang manpage zsh-syntax-highlighting)

# Load them from ZSHFUNC location
for plugin ($plugins); do
  source $ZSHFUNC/$plugin.zsh
done

# zsh options
setopt nohashdirs
unsetopt correct_all
setopt correct
setopt completealiases
setopt HIST_IGNORE_SPACE 

# shell settings
#set -eu
set -o pipefail
# zsh-syntax-highlighting options
# source and instructions see: https://github.com/zsh-users/zsh-syntax-highlighting

# highlighters to use
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern line)
# override highlighters 
typeset -A ZSH_HIGHLIGHT_STYLES
# remove all underline in main
ZSH_HIGHLIGHT_STYLES[suffix-alias]='fg=green,none'
ZSH_HIGHLIGHT_STYLES[path]='none'
ZSH_HIGHLIGHT_STYLES[path_prefix]='none'
ZSH_HIGHLIGHT_STYLES[precommand]='fg=gree,none'

# Stuff transfered from .bashrc
#xhost +local:root > /dev/null 2>&1
#export HISTCONTROL=ignoreboth

# set default apps
export EDITOR="nvim"
export BROWSER=/usr/bin/firefox

# set colors for ls colored output
eval $(dircolors ~/.dircolors)

# set aliasses
alias ls='ls --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F'
alias ll='ls -l --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F'
alias la='ls -la --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F'
alias grep='grep --color=tty -d skip'
alias cp="cp -i"                          # confirm before overwriting something
alias df='df -h'                          # human-readable sizes
alias free='free -m'                      # show sizes in MB
alias rm='rm -I'
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
# Copy and paste to/from clipboard
alias pbcopy='xsel --clipboard --input'
alias pbpaste='xsel --clipboard --output'
# Set pulseaudio volume to valua with pamixer
#alias setvolume='pamixer --set-volume'
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
# Path for local nodejs modules
export PATH=$PATH:$HOME/node_modules/.bin
export GOPATH=$HOME/gocode
export PATH=$PATH:$GOPATH/bin
# Path for ruby gems
export PATH=$PATH:$HOME/.gem/ruby/2.3.0/bin
