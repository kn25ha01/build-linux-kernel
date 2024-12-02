# Build Linux Kernel

## Get the Linux kernel source

```
$ wget https://cdn.kernel.org/pub/linux/kernel/v6.x/linux-6.12.1.tar.xz
$ mkdir linux
$ tar xf linux-6.12.1.tar.xz -C linux --strip-components=1
```

## Build the Linux kernel source inside a Docker container

~~Copy the configuration file.~~

~~$ sudo cp /boot/config-6.8.0-45-generic ./linux/.config~~

Start a Docker container.

```
$ docker compose up -d --build
$ docker exec -it build-linux-kernel /bin/bash
```

Verify the current kernel version before updating.

```
# uname -r
6.8.0-45-generic
```

Update the configuration file.
Inside the Docker container, run `make menuconfig` instead of `make olddefconfig`.

```
# make menuconfig
```

Build the Linux kernel source and generate the [bzImage](https://ja.wikipedia.org/wiki/Vmlinux#bzImage) file.

```
# make -j8 bzImage modules 1>build.log
```

Install the kernel modules to `/lib/modules` and the vmlinux file to `/boot/vmlinux`.　(The basic premise is that containers do not have a kernel, but use the kernel of the host OS. In fact, nothing will happen if you install it in this directory.)

```
# make modules_install install 1>install.log
```

Verify the kernel version after updating. (Since the host OS kernel has not been updated, the kernel version seen by the container does not change.)

```
# exit
$ docker compose restart
$ docker exec -it build-linux-kernel /bin/bash
# uname -r
6.8.0-45-generic
```
