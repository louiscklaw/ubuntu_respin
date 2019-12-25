#!/usr/bin/env bash

docker --version

# NOTE: for local test only
# docker kill dell-xps-9560-ubuntu-respin-container

# bash ./scripts/docker-build-image.sh

bash ./scripts/get_images.sh

docker run -t --rm --cap-add MKNOD -v $PWD/origin:/docker-input -v $PWD/destination:/docker-output --privileged --name dell-xps-9560-ubuntu-respin-container dell-xps-9560-ubuntu-respin:latest bash build.sh docker-input/ubuntu_1804.iso -c bionicbeaver
