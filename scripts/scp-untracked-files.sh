#!/bin/bash
#set -x
rm -rf /tmp/untracked
mkdir /tmp/untracked
cd ../
git ls-files --others | xargs -I {} cp --parents {} /tmp/untracked
#tree /tmp/untracked
cd /tmp/untracked
# remove the toolchains from tarball
find . -name '*\-toolchain\-3.0.1*' -delete
find . -name '*\-toolchain-ext-3.0.1*' -delete
# tree after we removed
tree /tmp/untracked
tar czvf ../untracked.tar.gz .
scp ../untracked.tar.gz rber@192.168.42.52:/tmp
#set +x
