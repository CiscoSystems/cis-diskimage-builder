#!/bin/bash

set -o pipefail

export ELEMENTS_PATH=`pwd`/elements
source dibrc

# Create all the images we want
disk-image-create -a amd64 -o images/trusty.qcow2 ubuntu base vm cisco
export DIB_RELEASE='precise'
./test_image.sh images/trusty.qcow2
disk-image-create -a amd64 -o images/precise.qcow2 ubuntu base vm cisco
./test_image.sh images/precise.qcow2
export DIB_RELEASE=""
disk-image-create -a amd64 -o images/fedora20.qcow2 fedora base vm cisco
./test_image.sh images/fedora20.qcow2
disk-image-create -a amd64 -o images/centos7.qcow2 centos7 base vm cisco
./test_image.sh images/centos7.qcow2
# This is a lame assumption that I'm trying to work around
export DIB_CLOUD_IMAGES="http://173.39.232.144/images/"
export BASE_IMAGE_FILE="rhel-guest-image-7.0-20140930.0.x86_64.qcow2"
export REG_METHOD='disable'
export REG_HALT_UNREGISTER=1
export DIB_YUM_REPO_CONF=`pwd`/redhat.repo
disk-image-create -a amd64 -o images/rhel7.qcow2 rhel7 base vm cisco
./test_image.sh images/rhel7.qcow2


