#!/bin/bash
set -e

SWIFT_TAG="swift-5.2-branch"

# setup image for compilation
docker build --build-arg SWIFT_TAG=${SWIFT_TAG}  -t compileimage .

# run compilation with advanced privileges
docker run --security-opt seccomp=unconfined --name compileswift compileimage 

# copy installable file to local
docker cp compileswift:/home/ec2-user/swift-package.tar.gz ./swift-package.tar.gz

# remove wrongly added /usr/lib/python2.7 symlink and rename to final name
if [[ "$OSTYPE" == "darwin"* ]]; then
  tar -czf ${SWIFT_TAG}-amazonlinux2.tar.gz --exclude 'usr/lib/python2.7' @swift-package.tar.gz
else
  pigz -d < swift-package.tar.gz \
    | tar --delete --wildcards -f - 'usr/lib/python2.7' \
    | pigz > ${SWIFT_TAG}-amazonlinux2.tar.gz
fi
