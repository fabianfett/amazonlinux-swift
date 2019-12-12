# amazonlinux-swift

Apple does not build Swift for any other Linux distribution besides
Ubuntu. Therefore it is in the hands of the community to bring Swift
to other distributons. This project wants to support Swift on the 
Server by bringing it to Amazon Linux.

This project creates three build artifacts for every Swift release:

1. An installable Swift binary
2. A Docker image that runs Swift based off the amazonlinux image
3. A Swift layer to run Swift natively on AWS Lambda

You can download the binaries at:
https://fabianfett.de/amazonlinux-swift

You download the Docker images at:
https://hub.docker.com/repository/docker/fabianfett/amazon-linux-swift

You can download the layer from:
https://fabianfett.de/amazonlinux-swift



## What is this repository about?

This repository stores all dockerfiles, scripts and readmes involved
in building Swift on Amazonlinux. If you would like to compile Swift
on Amazon Linux yourself, feel free to use everything offered here.

## Contributing

Please feel welcome and encouraged to contribute to amazonlinux-swift.
If you have questions or feedback please create a GitHub issue.

If you like this, I'm excited about GitHub stars. 🤓 

## Credits

This would not have been possible without the truly awesome work of 
some open source contributors before me.

- [Build Swift on Amzn Ami](https://gist.github.com/carsonmcdonald/8edeb5ac745a1e94699e)
- [Swift on Fedora](https://github.com/FedoraSwift/fedora-swift2)
- [Swift Issue 100](https://bugs.swift.org/browse/SR-100)
