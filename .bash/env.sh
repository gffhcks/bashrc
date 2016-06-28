#!/bin/bash

# ENV
# Miscellaneous environment customizations

# Dynamic reloads
alias reload='source ~/.bashrc'

# Tell ls to be colorful
export CLICOLOR=1
export LSCOLORS=Exfxcxdxbxegedabagacad

# Tell grep to highlight matches
export GREP_OPTIONS='--color=auto'

# EOPS puppet tools
export PATH=$PATH:$HOME/git/eops-tools/puppet
# Personal tools
export PATH=$PATH:$HOME/bin

# Load private-file
[[ -s "$HOME/.bash/.private" ]] && source $HOME/.bash/.private
