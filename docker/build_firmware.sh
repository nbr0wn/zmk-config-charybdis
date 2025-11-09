#!/bin/bash

# This script is meant to be run from inside the container.
# Run podman_bash.sh first.  This directory will be mounted at
# /workspaces/zmk-config/docker

CONF=/tmp/zmk-config
BUILD=/tmp/zmk-build
OUTPUT_DIR=/workspaces/zmk-config

# Cleanup
rm -rf $BUILD
mkdir $BUILD

# Export paths for building
cd $CONF
west zephyr-export

# Do the build
west build --pristine \
	-b nice_nano_v2 \
	-s zmk/app \
        -d $BUILD \
        -S "studio-rpc-usb-uart" \
        -- \
        -DSHIELD=charybdis_left \
        -DZMK_CONFIG=$CONF/config/ \
        -DZMK_STUDIO=y 

cp $BUILD/zephyr/zmk.uf2 $OUTPUT_DIR/charybdis_left.uf2

rm -rf /tmp/zmk-build
mkdir $BUILD

west build --pristine \
	-b nice_nano_v2 \
	-s zmk/app \
        -d $BUILD \
        -S "studio-rpc-usb-uart" \
        -- \
        -DSHIELD=charybdis_right \
        -DZMK_CONFIG=$CONF/config/ \
        -DZMK_STUDIO=y

cp $BUILD/zephyr/zmk.uf2 $OUTPUT_DIR/charybdis_right.uf2
