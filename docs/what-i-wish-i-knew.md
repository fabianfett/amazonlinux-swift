## Caveats

- only Amazon Linux 2 is officially supported
- 

## Build an image for compiling

```
FROM fabianfett/amazon-linux-swift:5.1.2-amazonlinux2

RUN yum -y update && \
  yum -y install zlib-devel kernel-devel gcc-c++
```

### Amazon Linux 2

tar -czvf ./new2.tar.gz --exclude='usr/lib/python2.7' @swift-package.tar.gz

LLVM_LIBDIR_SUFFIX swift 64
--llvm-cmake-options=-DLLVM_LIBDIR_SUFFIX=64

```bash
$ ldd binary
```


### Amazon Linux 1

glibc 2.17; needed glibc 2.19
https://bugzilla.redhat.com/show_bug.cgi?id=1009623


# Run the actual build. Disable unit tests.
# RUN ./utils/build-script --preset=buildbot_linux,no_test installable_package=/home/ec2-user/swift-package.tar.gz install_destdir=/tmp/swift  --llvm-cmake-options=-LLVM_LIBDIR_SUFFIX:STRING=64

