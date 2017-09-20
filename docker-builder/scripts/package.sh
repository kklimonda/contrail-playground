#!/bin/bash
set -e

DISTRO=$1
SERIES=$2
CONTRAIL_VNC=$3
BRANCH=$4
VERSION=$5
JOBS=$6

REPO=/tmp/contrail/bin/repo
mkdir /tmp/contrail/{,bin,build}
wget https://storage.googleapis.com/git-repo-downloads/repo -O $REPO

chmod +x $REPO

export HOME=/tmp/contrail/

git config --global user.email "builder@local"
git config --global user.name "OpenContrail Builder"
git config --global color.ui false

cd /tmp/contrail/build/
$REPO init -u $CONTRAIL_VNC -m default.xml
$REPO sync

function package_ubuntu()
{
    export DEB_BUILD_OPTIONS="parallel=${JOBS}"
    cd /tmp/contrail/build/
    cp -R tools/packages/debian/contrail/debian .

    if ! [[ "${VERSION}" == *"-"* ]]; then
        DEB_VERSION="${VERSION}-1"
    else
        DEB_VERSION=${VERSION}
    fi

    dch -v ${DEB_VERSION} -m "" && dch --release --distribution ${SERIES} -m "Releasing version ${DEB_VERSION}."
    fakeroot debian/rules get-orig-source && mv contrail_${VERSION}.orig.tar.gz ../
    debuild -us -uc -i 
}

if [ -e "/scripts/local_patches.sh" ]; then
    . /scripts/local_patches.sh
fi

if [[ "$DISTRO" == "ubuntu" ]]; then
    package_ubuntu
    mv /tmp/contrail/*.deb /target/
    ls -l /tmp/contrail/
fi
