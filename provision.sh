#!/bin/sh

sudo sed -e 's|^metalink=|#metalink=|g' \
         -e 's|^#baseurl=http://download.fedoraproject.org/pub/fedora/linux|baseurl=https://mirrors.ustc.edu.cn/fedora|g' \
         -i.bak \
         /etc/yum.repos.d/fedora.repo \
         /etc/yum.repos.d/fedora-modular.repo \
         /etc/yum.repos.d/fedora-updates.repo \
         /etc/yum.repos.d/fedora-updates-modular.repo

# These groups could not be found on fedora cloud
# dnf group install -y "X Window System" "GNOME Desktop Environment"

dnf remove -y libnfsidmap-1:2.3.3-7.rc2.fc30.x86_64 # Resolve a conflict with below group.
# i3, xmonad, openbox are installed, see `dnf group info 'Basic Desktop'`
dnf group install -y 'Basic Desktop'

dnf install -y dbus-devel cairo-gobject-devel

PIP_OPTIONS="--trusted-host mirrors.ustc.edu.cn --index-url https://mirrors.ustc.edu.cn/pypi/web/simple"

pip3 install $PIP_OPTIONS -U pip setuptools
pip3 install $PIP_OPTIONS 'xcffib >= 0.5.0'
pip3 install $PIP_OPTIONS --no-cache-dir 'cairocffi >= 0.9.0'
pip3 install $PIP_OPTIONS \
     cffi >= 1.1.0 \
     dbus-python \
     pygobject \
     pytest \
     iwlib \
     keyring \
     psutil \
     xdg \
     flake8 \
     pep8-naming \
     psutil \
     pytest-cov
