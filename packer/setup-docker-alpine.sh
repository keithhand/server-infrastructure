#! /usr/bin/env sh

# Install docker
apk add docker

# Start docker on boot
rc-update add docker boot
