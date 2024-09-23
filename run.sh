#!/bin/bash
docker build -t devcontainer . && docker run --rm -it --hostname devcontainer -v devcontainer-workspace:/workspace devcontainer
