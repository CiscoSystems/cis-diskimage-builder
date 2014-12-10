:# cis-diskimage-builder

This repository houses custom elements for use with Openstack diskimage-builder

## Usage

Automated creation and testing of images is scripted by
		
		build_images.sh
		
## Setup
Install diskimage-builder either from pypi or [github](https://github.com/openstack/diskimage-builder) (Recommneded)

        pip install -r requirements.txt

or latest from source

        git clone https://github.com/openstack/diskimage-builder.git
        cd diskimage-builder
        sudo python setup.py install
        cd
        git clone http://cis-gerrit.cisco.com/cis-diskimage-builder
		export ELEMENT_PATH={path to this repo}/elements
        disk-image-create -a amd64 -o disk-name {element} [element] cisco
	

### Example

        disk-image-create -a amd64 -o trusty.qcow2 ubuntu vm cisco
        disk-image-create -a amd64 -o rhel7.qcow2 rhel7 vm cisco

## Directories

* root.d: Create or adapt the initial root filesystem content. This is where
  alternative distribution support is added, or customisations such as
  building on an existing image. 

  Only one element can use this at a time unless particular care is taken not
  to blindly overwrite but instead to adapt the context extracted by other
  elements.

 * runs: outside chroot
 * inputs: $ARCH=i386|amd64|armhf $TARGET\_ROOT=/path/to/target/workarea

* extra-data.d: pull in extra data from the host environment that hooks may
  need during image creation. This should copy any data (such as SSH keys,
  http proxy settings and the like) somewhere under $TMP\_HOOKS\_PATH.

 * runs: outside chroot
 * inputs: $TMP\_HOOKS\_PATH
 * outputs: None

* pre-install.d: Run code in the chroot before customisation or packages are
  installed. A good place to add apt repositories.

 * runs: in chroot

* install.d: Runs after pre-install.d in the chroot. This is a good place to
  install packages, chain into configuration management tools or do other
  image specific operations.

 * runs: in chroot

* post-install.d: Run code in the chroot. This is a good place to perform
  tasks you want to handle after the OS/application install but before the
  first boot of the image. Some examples of use would be: Run chkconfig
  to disable unneeded services and clean the cache left by the package
  manager to reduce the size of the image.

 * runs: in chroot

* block-device.d: customise the block device that the image will be made on
  (e.g. to make partitions). Runs after the target tree has been fully
  populated but before the cleanup hook runs.

 * runs: outside chroot
 * inputs: $IMAGE\_BLOCK\_DEVICE={path} $TARGET\_ROOT={path}
 * outputs: $IMAGE\_BLOCK\_DEVICE={path}

* finalise.d: Perform final tuning of the root filesystem. Runs in a chroot
  after the root filesystem content has been copied into the mounted
  filesystem: this is an appropriate place to reset SELinux metadata, install
  grub bootloaders and so on. Because this happens inside the final image, it
  is important to limit operations here to only those necessary to affect the
  filesystem metadata and image itself. For most operations, post-install.d
  is preferred.

 * runs: in chroot

* cleanup.d: Perform cleanup of the root filesystem content. For
  instance, temporary settings to use the image build environment HTTP proxy
  are removed here in the dpkg element.

 * runs: outside chroot
 * inputs: $ARCH=i386|amd64|armhf $TARGET\_ROOT=/path/to/target/workarea
