The ramdisk image for Firefly-RK3288 board and other rockchip based platforms.

### How to generate the ramdisk ###

After cloning, cd to the working directory, and run:

    make

a new initrd.img will be created in the parent directory.

### Credit ###

Based on https://github.com/radxa/initrd.git which is
based on https://github.com/Galland/rk30_linux_initramfs which is
based on fkubi's initramfs who in turn
based on Debian's initramfs.cpio.
