#!/bin/bash

# VIRTUALENV
# Setup and custom tools for virtualenv

# Add virtualenv home to system vars
export WORKON_HOME=~/.virtualenvs
[[ -s "/usr/local/bin/virtualenvwrapper.sh" ]] && source /usr/local/bin/virtualenvwrapper.sh

# Alias to bring up a new venv with python3
alias mkvirtualenv3='mkvirtualenv --python=$BREWPATH/bin/python3'

# Delete virtual env
function delvirtualenv {
    local ENV_NAME=$1
    [ -z "$ENV_NAME" ] && return
    [[ -d "$WORKON_HOME/$ENV_NAME" ]] && rm -rf "$WORKON_HOME/$ENV_NAME"
}


# Automatically activate Git projects' virtual environments based on the
# directory name of the project. Virtual environment name can be overridden
# by placing a .venv file in a directory or at the root of the repo.
# Based on http://hmarr.com/2010/jan/19/making-virtualenv-play-nice-with-git/
function workon_cwd {
    local ENV_NAME
    local GIT_DIR
    local PROJECT_ROOT
    if [[ -e "$PWD/.venv" ]]; then
        # The .venv of the current directory always gets priority.
        ENV_NAME=`cat "$PWD/.venv"`
    else
        # Check that this is a Git repo
        GIT_DIR=`git rev-parse --git-dir 2> /dev/null`
        if [ $? == 0 ]; then
            # Find the repo root and use it for the venv name.
            GIT_DIR=`\cd $GIT_DIR; pwd`
            PROJECT_ROOT=`dirname "$GIT_DIR"`
            ENV_NAME=`basename "$PROJECT_ROOT"`
            if [ -f "$PROJECT_ROOT/.venv" ]; then
                # A .venv in the project root overrides the repo name.
                ENV_NAME=`cat "$PROJECT_ROOT/.venv"`
            fi
        fi
    fi
    if [ ! -z "$ENV_NAME" ] && [ -e "$WORKON_HOME/$ENV_NAME/bin/activate" ]; then
        # If an env name was found and the venv exists, use it
        # Activate the environment only if it is not already active
        if [ "$VIRTUAL_ENV" != "$WORKON_HOME/$ENV_NAME" ]; then
            workon "$ENV_NAME" && export CD_VIRTUAL_ENV="$ENV_NAME"
        fi
    elif [ $CD_VIRTUAL_ENV ]; then
        # We've just left the repo, deactivate the environment
        # Note: this only happens if the virtualenv was activated automatically
        deactivate && unset CD_VIRTUAL_ENV
    fi
}

# New cd function that does the virtualenv magic
function venv_cd {
    cd "$@" && workon_cwd
}

# WARNING - This will override any other CD customizations/aliases
alias cd="venv_cd"
