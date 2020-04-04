#!/usr/bin/env bash

set -ex

docker --version

# docker rm $(docker ps -qa)

# NOTE: for local test only
# docker kill dell-xps-9560-ubuntu-respin-container

# bash ./_utils/get_images.sh
bash ./scripts/docker-build-image.sh


if [ ! -f origin/ubuntu-18.04.4-desktop-amd64.iso ]; then
    echo 'download image'
    bash ./scripts/get_images.sh
else
    # iso image file found
    echo 'skip download image'
fi

cp ./scripts/build_all.sh ./scripts/isorespin.sh /home/logic/_workspace/ubuntu_respin/origin/

docker run -t --rm --cap-add MKNOD \
    -v $PWD/origin:/docker-input \
    -v $PWD/destination:/docker-output \
    --privileged \
    --name dell-xps-9560-ubuntu-respin-container logickee/dell-xps-9560-ubuntu-respin:latest \
    bash build.sh docker-input/ubuntu-18.04.4-desktop-amd64.iso -c bionicbeaver
