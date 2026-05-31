SHELL := /usr/bin/env bash

.PHONY: help host-check fetch-sources fetch-blfs-sources prepare-rootfs prepare-chroot prepare-desktop-config prepare-live-config mount-rootfs umount-rootfs enter-chroot build-live-initramfs build-toolchain build-chroot-temp build-base build-blfs-base build-desktop make-iso

help:
	@printf '%s\n' \
	  'Kalyx targets:' \
	  '  make host-check       Validate the Linux build host' \
	  '  make fetch-sources    Download and verify LFS sources' \
	  '  make fetch-blfs-sources Download BLFS sources' \
	  '  make prepare-rootfs   Create the initial Kalyx rootfs skeleton' \
	  '  make prepare-chroot   Prepare ownership, dirs, files, and mounts for chroot' \
	  '  make prepare-desktop-config Configure reduced XFCE defaults' \
	  '  make prepare-live-config Configure live XFCE defaults in the rootfs' \
	  '  make mount-rootfs     Mount pseudo-filesystems for chroot' \
	  '  make umount-rootfs    Unmount pseudo-filesystems' \
	  '  make enter-chroot     Enter the Kalyx rootfs chroot' \
	  '  make build-live-initramfs Build the live squashfs initramfs' \
	  '  make build-toolchain  Run toolchain recipe phase' \
	  '  make build-chroot-temp Run temporary chroot tools phase' \
	  '  make build-base       Run base-system recipe phase' \
	  '  make build-blfs-base  Run minimal BLFS graphics/network phase' \
	  '  make build-desktop    Run desktop recipe phase' \
	  '  make make-iso         Prepare an ISO tree and run grub-mkrescue'

host-check:
	bash scripts/host-check

fetch-sources:
	bash scripts/fetch-sources

fetch-blfs-sources:
	bash scripts/fetch-blfs-sources

prepare-rootfs:
	bash scripts/prepare-rootfs

prepare-desktop-config:
	bash scripts/prepare-desktop-config

prepare-live-config:
	bash scripts/prepare-live-config

mount-rootfs:
	bash scripts/mount-rootfs

umount-rootfs:
	bash scripts/umount-rootfs

enter-chroot:
	bash scripts/enter-chroot

build-live-initramfs:
	bash scripts/build-live-initramfs

build-toolchain:
	bash scripts/build-toolchain

build-chroot-temp:
	bash scripts/build-chroot-temp

build-base:
	bash scripts/build-base

prepare-chroot:
	bash scripts/prepare-chroot

build-blfs-base:
	bash scripts/build-blfs-base

build-desktop:
	bash scripts/build-desktop

make-iso:
	bash scripts/make-iso
