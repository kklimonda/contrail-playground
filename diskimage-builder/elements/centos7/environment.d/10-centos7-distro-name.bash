export DISTRO_NAME=centos7

if [ -z "$DIB_RELEASE" ]; then
    export DIB_RELEASE=GenericCloud
fi

# Useful for elements that work with fedora (dnf) & centos
export YUM=${YUM:-yum}

