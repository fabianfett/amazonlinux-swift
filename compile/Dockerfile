FROM amazonlinux:2

# required to get addgroup / adduser
RUN yum -y update && yum install shadow-utils.x86_64 -y 

# add a new group and user
RUN groupadd -g 127 ec2-user && \  
    useradd -m -r -u 127 -g ec2-user ec2-user 

WORKDIR /home/ec2-user

ARG SWIFT_TAG="swift-5.2-branch"

# The build needs a package from the EPEL repo so that needs to be enabled.
# https://www.tecmint.com/install-epel-repository-on-centos/
RUN yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm

# Update and install needed build packages
RUN yum -y update
RUN yum -y group install "development tools"
RUN yum -y install \
      git clang python swig uuid-devel libicu-devel libedit-devel \
      libxml2-devel sqlite-devel ncurses-devel pkgconfig python-devel \
      python-pkgconfig libbsd-devel libuuid-devel pexpect curl-devel \
      tzdata rsync wget which procps

# Grab an updated version of cmake
RUN wget -qO- "https://cmake.org/files/v3.16/cmake-3.16.3-Linux-x86_64.tar.gz" \
      | tar --strip-components=1 -xz -C /usr/local

USER ec2-user

# Add updated version of cmake to path 
ENV PATH="/usr/local/bin/:${PATH}"

# Create sym link because of stupid lib64/python
RUN mkdir -p build \
    && mkdir -p build/buildbot_linux/lldb-linux-x86_64/lib \
    && mkdir -p build/buildbot_linux/lldb-linux-x86_64/lib64/python2.7 \
    && ln -s build/buildbot_linux/lldb-linux-x86_64/lib64/python2.7 build/buildbot_linux/lldb-linux-x86_64/lib/python2.7

# Bootstrap the swift source and do a full checkout
RUN git clone --branch ${SWIFT_TAG} https://github.com/apple/swift.git
WORKDIR /home/ec2-user/swift
RUN ./utils/update-checkout --clone --scheme ${SWIFT_TAG}

# Add skip-test-foundation to buildbot_linux preset
RUN sed -i '785 a skip-test-foundation' utils/build-presets.ini

CMD /home/ec2-user/swift/utils/build-script --preset=buildbot_linux installable_package=/home/ec2-user/swift-package.tar.gz install_destdir=/tmp/swift
