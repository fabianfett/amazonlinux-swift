FROM amazonlinux:2

WORKDIR /home/ec2-user

ARG SWIFT_TAG="swift-5.2.1-RELEASE"

# The build needs a package from the EPEL repo so that needs to be enabled.
# https://www.tecmint.com/install-epel-repository-on-centos/
RUN yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm

# Update and install needed build packages
RUN yum -y update
RUN yum -y group install "development tools"
RUN yum -y install \
      git cmake clang python swig uuid-devel libicu-devel libedit-devel \
      libxml2-devel sqlite-devel ncurses-devel pkgconfig python-devel \
      python-pkgconfig libbsd-devel libuuid-devel pexpect curl-devel \
      tzdata rsync wget which

# Grab an updated version of cmake
RUN wget https://cmake.org/files/v3.15/cmake-3.15.5-Linux-x86_64.tar.gz \
      && tar xvzf cmake-3.15.5-Linux-x86_64.tar.gz \
      && rm cmake-3.15.5-Linux-x86_64.tar.gz

# Add updated version of cmake to path 
ENV PATH="/home/ec2-user/cmake-3.15.5-Linux-x86_64/bin/:${PATH}"

# Cloning ninja into the root build area will cause it to be built by
# the build script and used instead of having to install a binary version
RUN git clone https://github.com/ninja-build/ninja.git

# Create sym link because of stupid lib64/python
RUN mkdir -p build \
    && mkdir -p build/buildbot_linux/lldb-linux-x86_64/lib \
    && mkdir -p build/buildbot_linux/lldb-linux-x86_64/lib64/python2.7 \
    && ln -s build/buildbot_linux/lldb-linux-x86_64/lib64/python2.7 build/buildbot_linux/lldb-linux-x86_64/lib/python2.7

# Bootstrap the swift source and do a full checkout
RUN git clone --branch ${SWIFT_TAG} https://github.com/apple/swift.git
WORKDIR /home/ec2-user/swift
RUN ./utils/update-checkout --clone --tag ${SWIFT_TAG}

CMD /home/ec2-user/swift/utils/build-script --preset=buildbot_linux,no_test installable_package=/home/ec2-user/swift-package.tar.gz install_destdir=/tmp/swift
