#!/bin/bash

# HOMEBREW
# Load and apply Homebrew-dependent environment customizations

export BREWPATH=$(brew --prefix)
export PATH=$BREWPATH/bin:$BREWPATH/sbin:$PATH

# Virtualenv and virtualenvwrapper
[[ -s "$BREWPATH/bin/virtualenvwrapper.sh" ]] && source $BREWPATH/bin/virtualenvwrapper.sh
# Chruby
[[ -s "$BREWPATH/opt/chruby/share/chruby/chruby.sh" ]] && source $BREWPATH/opt/chruby/share/chruby/chruby.sh
[[ -s "$BREWPATH/opt/chruby/share/chruby/auto.sh" ]] && source $BREWPATH/opt/chruby/share/chruby/auto.sh
# 'most' instead of 'less'
[[ -s "$BREWPATH/bin/most" ]] && export PAGER="$BREWPATH/bin/most -s"
# pass less through syntax highlighter
[[ -s "$BREWPATH/bin/src-hilite-lesspipe.sh" ]] && export LESSOPEN="| $BREWPATH/bin/src-hilite-lesspipe.sh %s" && export LESS=' -R '
# Bash completion
[[ -f $BREWPATH/etc/bash_completion ]] && . $BREWPATH/etc/bash_completion
# GOROOT
[[ -s "$BREWPATH/opt/go/libexec" ]] && export GOROOT=$BREWPATH/opt/go/libexec
# Direnv
[[ -s "$BREWPATH/bin/direnv" ]] && eval "$(direnv hook bash)"
