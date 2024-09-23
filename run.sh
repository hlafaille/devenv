#!/bin/bash
docker build -t devenv . && docker run --rm -it --hostname devenv -v devenv_workspace:/workspace -v ~/.ssh:/home/dev/.ssh -v ~/.gitconfig:/home/dev/.gitconfig devenv
