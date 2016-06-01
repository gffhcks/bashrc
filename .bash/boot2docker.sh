#!/bin/bash

# BOOT2DOCKER

# alias b2d='boot2docker'
# # Bring up an empty boot2docker

# alias b2dreset='b2d stop; b2d init; b2d up; eval "$(b2d shellinit)"'

# # Set up boot2docker if it's running
# [[ $(b2d status) == "running" ]] && eval "$(b2d shellinit)"

# Run a basic Ubuntu test container
function ubuntu() {
    local ubuntu_volumes='-v /Users/ghicks/Stash:/Stash'
    ubuntu_volumes="$ubuntu_volumes -v /Users/ghicks/GitHub:/GitHub"
    ubuntu_volumes="$ubuntu_volumes -v /Users/ghicks/.aws:/root/.aws"
    # [[ $(b2d status) != "running" ]] && b2d up && eval "$(b2d shellinit)"
    docker rm -fv ubuntu-testbed
    docker build -t ubuntu-testbed ~/ubuntu-testbed
    docker run -it --name ubuntu-testbed $ubuntu_volumes ubuntu-testbed /bin/bash
}


function ubuntu-pypi() {
    local ubuntu_volumes='-v /Users/ghicks/Stash:/Stash'
    ubuntu_volumes="$ubuntu_volumes -v /Users/ghicks/GitHub:/GitHub"
    ubuntu_volumes="$ubuntu_volumes -v /Users/ghicks/.aws:/root/.aws"
    # [[ $(b2d status) != "running" ]] && b2d up && eval "$(b2d shellinit)"
    docker rm -fv ubuntu-testbed
    docker build -t ubuntu-testbed ~/ubuntu-testbed
    docker run --name ubuntu-pypi $ubuntu_volumes ubuntu-testbed
}
