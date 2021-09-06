# ofAppImage

This project assists in the creation of AppImages for openFrameworks on Linux.
The AppImages created from this guide should run on all Linux distros that have GLIBC of a version equal to or greater than 2.23, which should be most distros released from around 2016 onwards.

To see what GLIBC your version of Linux has (provided you have development tools installed), type this in a terminal:
```
ldd --version
```

## Prerequisites

### VirtualBox running Ubuntu 16.04
First you need to install a Virtual Machine (VM) running Ubuntu 16.04.
As of writing the current version of Ubuntu available is 16.04.7
Follow the on-line guides to install Virtualbox - the version I used was 6.1. 

### Install GCC6
In order to run the latest openFrameworks (0.11.x) on Ubuntu 16.04, you'll need to install GCC 6:

```
sudo apt-get update && \
sudo apt-get install build-essential software-properties-common -y && \
sudo add-apt-repository ppa:ubuntu-toolchain-r/test -y && \
sudo apt-get update && \
sudo apt-get install gcc-6 g++-6 -y && \
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-6 60 --slave /usr/bin/g++ g++ /usr/bin/g++-6 && \
gcc -v
```


