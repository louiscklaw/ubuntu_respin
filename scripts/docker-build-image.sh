#!/bin/bash

set -ex

cd .docker
    docker build -t logickee/dell-xps-9560-ubuntu-respin .
cd -
