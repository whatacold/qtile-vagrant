
This is a vagrant box for playing [Qtile](https://github.com/qtile/qtile) based on Fedora Cloud with Basic Desktop, including:

- LightDM

- Various window managers including Qtile, i3, etc.

  Choose your favorite WM on the upper-right corner of the screen when logging in, if Qtile is not your type.

# Files not synchronized in Vagrant?

1. Change the type of `synced_foleder` to `rsync`

   The result should be:

        $ ag synced ~/.vagrant.d/boxes/fedora-VAGRANTSLASH-Fedora-Cloud-Base-Vagrant-30
        /home/hgw/.vagrant.d/boxes/fedora-VAGRANTSLASH-Fedora-Cloud-Base-Vagrant-30/0/virtualbox/Vagrantfile
        3:  config.vm.synced_folder ".", "/vagrant", type: "rsync"

2. Sync files by running `vagrant rsync` or `vagrant rsync-auto`

