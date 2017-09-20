_XTRACE_CONTRAIL=$(set +o | grep xtrace)
_ERROR_CONTRAIL=$(set +o | grep errexit)
set -x
set -e
CONTROLLER_PATCHSETS="
34917
34918
34919
34920
34924
34986
35098
35542
35676
35682
35636
35773
"
BUILD_PATCHSETS="
34915
34916
"

(cd controller/ &&
git remote add gerrit https://review.opencontrail.org/Juniper/contrail-controller/ || /bin/true
for patchset in $CONTROLLER_PATCHSETS; do
    hash_ref=$(git ls-remote gerrit | egrep "refs/changes/.*$patchset.*/" | tail -1)
    hash=$(echo $hash_ref |cut -d' ' -f1)
    ref=$(echo $hash_ref |cut -d' ' -f2)
    git fetch gerrit $ref
    git cherry-pick $hash
done)

(cd tools/build/ &&
git remote add gerrit https://review.opencontrail.org/Juniper/contrail-build/ || /bin/true
for patchset in $BUILD_PATCHSETS; do
    hash_ref=$(git ls-remote gerrit | egrep "refs/changes/.*$patchset.*/" | tail -1)
    hash=$(echo $hash_ref |cut -d' ' -f1)
    ref=$(echo $hash_ref |cut -d' ' -f2)
    git fetch gerrit $ref
    git cherry-pick $hash
done)
$_ERROR_CONTRAIL
$_XTRACE_CONTRAIL
