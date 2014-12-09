#!/bin/bash

export ELEMENTS_PATH=`pwd`/elements
source dibrc

# Create all the images we want
disk-image-create -a amd64 -o images/trusty.qcow2 ubuntu base vm cisco
export DIB_RELEASE='precise'
disk-image-create -a amd64 -o images/precise.qcow2 ubuntu base vm cisco
export DIB_RELEASE=""
disk-image-create -a amd64 -o images/fedora20.qcow2 fedora base vm cisco
disk-image-create -a amd64 -o images/centos7.qcow2 centos7 base vm cisco
# This is a lame assumption that I'm trying to work around
export DIB_CLOUD_IMAGES="http://173.39.232.144/images/"
export BASE_IMAGE_FILE="rhel-guest-image-7.0-20140930.0.x86_64.qcow2"
export REG_METHOD='portal'
export REG_AUTO_ATTACH=1
disk-image-create -a amd64 -o images/rhel7.qcow2 rhel7 base vm cisco


