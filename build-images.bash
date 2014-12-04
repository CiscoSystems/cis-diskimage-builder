#!/bin/bash

export ELEMENTS_PATH=`pwd`/elements
source dibrc

# Create all the images we want
disk-image-create -a amd64 -o trusty.qcow2 ubuntu base vm cisco
export DIB_RELEASE='precise'
disk-image-create -a amd64 -o precise.qcow2 ubuntu base vm cisco
export DIB_RELEASE=""
disk-image-create -a amd64 -o centos7.qcow2 centos7 base vm cisco
# This is a lame assumption that I'm trying to work around
export DIB_CLOUD_IMAGES="http://173.39.232.144/images/"
export BASE_IMAGE_FILE="rhel-guest-image-7.0-20140618.1.x86_64.qcow2"
export REG_METHOD='portal'
export REG_AUTO_ATTACH=1
disk-image-create -a amd64 -o rhel7.qcow2 rhel7 base vm cisco


