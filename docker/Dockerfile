FROM amazonlinux:2

ARG SWIFT_TAG="swift-5.2.1-RELEASE"

RUN yum -y update && \
  yum -y install libatomic libedit gcc git

ADD ${SWIFT_TAG}-amazonlinux2.tar.gz /
