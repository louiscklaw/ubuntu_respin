#!/usr/bin/env bash

docker --version

# NOTE: for local test only
# docker kill dell-xps-9560-ubuntu-respin-container

# bash ./_utils/get_images.sh
bash docker-build-image.sh

if [ ! -f origin/ubuntu_1804.iso ]; then
    echo 'download image'
    bash ./_utils/get_images.sh
else
    echo 'skip download image'
fi


docker run -t --rm --cap-add MKNOD -v $PWD/origin:/docker-input -v $PWD/destination:/docker-output --privileged --name dell-xps-9560-ubuntu-respin-container dell-xps-9560-ubuntu-respin:latest bash build.sh docker-input/ubuntu_1804.iso -c bionicbeaver
