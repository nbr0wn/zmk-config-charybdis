#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cd $SCRIPT_DIR

podman build -t zmk \
	--build-arg ZEPHYR_SDK_VERSION=0.17.0 \
	--build-arg ZEPHYR_VERSION=4.2.1 \
	--build-arg ARCHITECTURE=arm \
	-f Dockerfile .
