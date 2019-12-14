#!/bin/sh

PIP_OPTIONS="--trusted-host mirrors.ustc.edu.cn --index-url https://mirrors.ustc.edu.cn/pypi/web/simple"

function dnf_install()
{
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
    dnf group install -y 'Basic Desktop'                # i3, xmonad, openbox are installed, see `dnf group info 'Basic Desktop'`

    # wireless-tools-devel is for iwlib.h
    dnf install -y gcc python3-devel dbus-devel cairo-gobject-devel wireless-tools-devel gobject-introspection-devel
    dnf install -y rxvt-unicode-256color-ml
}

function install_pip_dependencies()
{
    if [ ! -f /home/vagrant/qtile-venv/bin/activate ]; then
        python3 -m venv /home/vagrant/qtile-venv/
    fi
    source /home/vagrant/qtile-venv/bin/activate

    pip install $PIP_OPTIONS -U pip setuptools
    pip install $PIP_OPTIONS wheel
    pip install $PIP_OPTIONS 'xcffib >= 0.5.0'
    pip install $PIP_OPTIONS --no-cache-dir 'cairocffi >= 0.9.0'
    pip install $PIP_OPTIONS \
        'cffi >= 1.1.0' \
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
}

function config_qtile_head()
{
    cat > /usr/share/xsessions/qtile-head.desktop <<EOF
[Desktop Entry]
Name=Qtile(HEAD)
Comment=Qtile(HEAD) Session
Exec=/vagrant/qtile/qtile-head-entry
#Exec=python3 /vagrant/qtile/bin/qtile
Type=Application
Keywords=wm;tiling
EOF
}

dnf_install
config_qtile_head

# switch user as vagrant
su vagrant
install_pip_dependencies
