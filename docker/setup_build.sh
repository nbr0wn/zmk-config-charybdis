#!/bin/bash

# This script is meant to be run from inside the container.
# Run podman_bash.sh first.  This directory will be mounted at
# /workspaces/zmk-config/docker

BUILD=/tmp/zmk-build

CONF=/workspaces/zmk-config
CONF=/workspaces/zmk-config/docker/zmk-charybdis
CONF=/workspaces/zmk-config/docker/zmk-config-charybdis

# Cleanup
rm -rf /tmp/zmk-config
rm -rf /tmp/zmk-build

# Copy over base config directory
cp -rp $CONF /tmp/zmk-config

# Init a west build in the temp directory
west init -l "/tmp/zmk-config/config"
cd /tmp/zmk-config

# Fetch all the modules the build requires
west update --fetch-opt=--filter=tree:0
