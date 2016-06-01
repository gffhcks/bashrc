#!/bin/bash

for f in ~/.bash/*.sh; do
    # echo $f #debug
    source $f
done
