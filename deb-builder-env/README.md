How to use it:

1. Install a clean 16.04 release
2. Install ansible `apt-get install ansible`
3. Clone this repository, and move content of the folder to /home/ubuntu/
4. Run `ansible-playbook prepare_builder.yaml`
5. Go to /home/ubuntu/contrail/
6. Run `fakeroot debian/rules get-orig-source`
7. Move the generated tarball: `contrail_4.1.0.0.orig.tar.gz to /home/ubuntu/contrail/`
8. Run the build: `DEB_BUILD_OPTIONS="parallel=16" eatmydata debuild -us -uc -i 2>&1 | ts '[%Y-%m-%d %H:%M:%.S]' | tee ../build.log`
