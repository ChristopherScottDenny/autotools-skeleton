#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

DEBVERSION=$(git describe --always)
DEBEMAIL=$(git config user.email)
DEBFULLNAME=$(git config user.name)
export DEBEMAIL DEBFULLNAME DEBVERSION

package_dir=/tmp/package/myprog-${DEBVERSION}/

mkdir -p ${package_dir}

rsync -avu --delete . ${package_dir} || exit
pushd ${package_dir} || exit

dh_make -e ${DEBEMAIL} --packagename myprog -c gpl3 --createorig --single -y -o ${SCRIPT_DIR}/debian
gbp dch

debuild -us -uc

popd
