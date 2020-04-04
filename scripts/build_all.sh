#!/usr/bin/env bash

set -ex

docker --version

# docker rm $(docker ps -qa)

# NOTE: for local test only
# docker kill dell-xps-9560-ubuntu-respin-container

# bash ./_utils/get_images.sh
bash docker-build-image.sh

if [ ! -f origin/ubuntu-18.04.4-desktop-amd64.iso ]; then
    echo 'download image'
    bash ./_utils/get_images.sh
else
    echo 'skip download image'
fi

cp /home/logic/_workspace/ubuntu_respin/_utils/build_all.sh /home/logic/_workspace/ubuntu_respin/isorespin.sh /home/logic/_workspace/ubuntu_respin/origin/

docker run -t --rm --cap-add MKNOD \
    -v $PWD/origin:/docker-input \
    -v $PWD/destination:/docker-output \
    --privileged \
    --name dell-xps-9560-ubuntu-respin-container logickee/dell-xps-9560-ubuntu-respin:latest \
    bash build.sh docker-input/ubuntu-18.04.4-desktop-amd64.iso -c bionicbeaver
