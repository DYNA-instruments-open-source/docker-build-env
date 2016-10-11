#!/bin/bash

docker_dir=$(dirname $(readlink -f $0))

test -r $docker_dir/Dockerfile || { echo "missing Dockerfile beside $0"; exit -1; }

test -r $docker_dir/.dockerignore || {
cat >$docker_dir/.dockerignore <<EOM
$(basename $(readlink -f $0))
EOM

}

exec docker build --build-arg http_proxy=$http_proxy --build-arg https_proxy=${https_proxy:-$http_proxy} --tag dynainstrumentsoss/build-env:centos7 $docker_dir
