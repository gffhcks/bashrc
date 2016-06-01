#!/bin/bash

# PS1
# Custom command prompt

 # Git branch in command prompt (__git_ps1)
[[ -s "$HOME/.bash/git-prompt.sh" ]] && source ~/.bash/git-prompt.sh

function __define_prompt()
{
    # local __resultvar=$1
    # Master BASH replacement list
    local BELL="\a"              # ASCII Bell
    local HRDATE="\d"            # Human-readable date (Mon Sep 06)
    local ESCAPE="\e"            # ASCII Escape (\033)
    local SHORTHOST="\h"         # First part of hostname ("mybox")
    local LONGHOST="\H"          # Full hostname ("mybox.mydomain.com")
    local SUSPENDED="\j"         # Number of suspended processes
    local TERMNAME="\l"          # Teminal identifier
    local NEWLINE="\n"           # ASCII Newline
    local CR="\r"                # ASCII carriage return
    local SHELL="\s"             # Shell name
    local TIME24="\t"            # Time in 24-hour format (23:01:01)
    local TIME12="\T"            # Time in 12-hour format (11:01:01)
    local TIMEAM="\@"            # Time in 12-hour format with AM/PM
    local USER="\u"              # Logged in user
    local VERSION="\v"           # Bash version (2.04)
    local PATCH="\V"             # Bash version plus patchlevel
    local DIR="\w"               # Current working dir
    local BASEDIR="\W"           # Basename of current working dir
    local HISTORY="\!"           # History buffer position
    local NUMBER="\#"            # Command number
    local ROOT="\$"              # Root indicator. "#" if root, "$" if non-root
    local BRANCH="\$(__git_ps1)" # Current git branch, empty if not in a git repo
    local BACKSLASH="\\"         # Put a backslash
    local WRAPESCAPE="\["        # word-wrap escape for non-printing chars
    local WRAPESCEND="\]"        # end word-wrap escape for non-printing chars

    # To put an arbitrary ASCII char, replace xxx with ascii number:
    # "\xxx"


    # Color formatting:
    #
    # Always begin with WRAPESCAPE \[
    # Then ASCII escape and openbracket: \e[
    # Then foreground/background/bold color options, separated by semicolon.
    # 0 = reset all
    # 1 = bold
    # 3x = FOREGROUND color (see list below)
    # 4x = BACKGROUND color (see list below)
    # Then end with an "m" and a WRAPESCEND.
    # 0 colorcode at the end will clear all formatting.
    #
    # Colors:
    # 0=black
    # 1=red
    # 2=green
    # 3=yellow
    # 4=blue
    # 5=magenta
    # 6=cyan
    # 7=white

    local N="\[\e[0m\]"   # clear all formatting
    local S="\[\e[1m\]"   # strong (bold)

    local R="\[\e[31m\]"  # red
    local G="\[\e[32m\]"  # green
    local B="\[\e[34m\]"  # blue
    local W="\[\e[37m\]"  # white
    local C="\[\e[36m\]"  # cyan
    local M="\[\e[35m\]"  # magenta
    local Y="\[\e[33m\]"  # yellow
    local K="\[\e[30m\]"  # black

    local BR="\[\e[41m\]" # background red
    local BG="\[\e[42m\]" # background green
    local BB="\[\e[44m\]" # background blue
    local BW="\[\e[47m\]" # background white
    local BC="\[\e[46m\]" # background cyan
    local BM="\[\e[45m\]" # background magenta
    local BY="\[\e[43m\]" # background yellow
    local BK="\[\e[40m\]" # background black

    # Titlebar:
    # WRAPESCAPE and \e]2;
    # Then text you want
    # Then \a and WRAPESCEND
    local TITLETEXT="$USER@$LONGHOST: $DIR"
    local TITLEBAR="\[\e]2;$TITLETEXT\a\]"

    # Put it all together!
    local PS1="$TITLEBAR$C$HISTORY$N $TIME24 $DIR$Y$BRANCH$N$ROOT "


    # if [[ "$__resultvar" ]]; then
        # eval $__resultvar="'$PS1'"
    # else
        echo "$PS1"
    # fi

}

PS1=$(__define_prompt)

