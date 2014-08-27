#!/bin/bash

export ELEMENTS_PATH=`pwd`/elements
source dibrc

# Create all the images we want
disk-image-create -a amd64 -o trusty.qcow2 ubuntu base vm cisco
export DIB_RELEASE='precise'
disk-image-create -a amd64 -o precise.qcow2 ubuntu base vm cisco
export DIB_RELEASE=""
disk-image-create -a amd64 -o centos7.qcow2 centos7 base vm cisco
disk-image-create -a amd64 -o rhel7.qcow2 rhel7 base vm cisco


