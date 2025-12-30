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
# .zshenv or .zshrc
fpath=( "$HOME/.zshfunctions" $fpath )

# Load pure theme
autoload -U promptinit; promptinit
# Pure prompt options
#PURE_PROMPT_SYMBOL=❯
PURE_PROMPT_SYMBOL=➞
prompt pure


zstyle ':completion:*' menu select
zstyle ':completion:*' rehash true

# PLUGINS
# list plugins
export ZSHFUNC=/Users/jorick/.zshfunctions
plugins=(grml-comp update manpage safe-paste)

# Load them from ZSHFUNC location
for plugin ($plugins); do
  source $ZSHFUNC/$plugin.zsh
done

# zsh options
setopt nohashdirs
unsetopt correct_all
setopt correct
setopt completealiases
# ignore command beginning with a space
setopt HIST_IGNORE_SPACE

# shell settings
#set -eu
set -o pipefail

# set default apps
export EDITOR="nvim"

# set colors for ls output
#eval $(dircolors ~/.dircolors)

# Set alias
alias ls='ls --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F'
alias ll='ls -lhs --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F'
alias la='ls -la --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F'
alias lla='ls -lahs --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F'
alias grep='grep --color=tty -d skip'
alias cp="cp -i"                          # confirm before overwriting something
alias rm='rm -I'
alias v='nvim'
alias m='micro'
alias ls='ls -GF'
alias ll='ls -GFl'
alias la='ls -GFa'
eval $(thefuck --alias)

# zsh-syntax-highlighting options
# source and instructions see: https://github.com/zsh-users/zsh-syntax-highlighting
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# highlighters to use
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern line)
# override highlighters
typeset -A ZSH_HIGHLIGHT_STYLES
# remove all underline in main
ZSH_HIGHLIGHT_STYLES[suffix-alias]='fg=green,none'
ZSH_HIGHLIGHT_STYLES[path]='none'
ZSH_HIGHLIGHT_STYLES[path_prefix]='none'
ZSH_HIGHLIGHT_STYLES[precommand]='fg=gree,none'

# PATH
export PATH="$PATH:$HOME/.local/bin"
export PATH="/usr/local/sbin:$PATH"
# RUBY
export PATH="/usr/local/opt/ruby/bin:$PATH"
export PATH="$PATH:/usr/local/lib/ruby/gems/3.1.0/bin"
export PATH="$PATH:/usr/local/lib/ruby/gems/3.0.0/bin"
# PYTHON
export PATH="$PATH:/usr/local/opt/python@3.10/libexec/bin"
export PATH="$PATH:$HOME/Library/Python/3.10/bin"
