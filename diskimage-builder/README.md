0. Download `http://cloud.centos.org/centos/7/images/CentOS-7-x86_64-GenericCloud-1503.qcow2`
1. Install virtualenv
2. `virtualenv --no-site-packages venv/`
3. `./venv/bin/pip install diskimage-builder`
4. `activate venv/bin/activate`
5. Edit build-centos7.sh and set `DIB_LOCAL_IMAGE` to the downloaded image path.
6. `./build-centos7.sh`
