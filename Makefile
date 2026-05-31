SHELL := /usr/bin/env bash

.PHONY: help host-check fetch-sources prepare-rootfs prepare-live-config build-toolchain build-base build-desktop make-iso

help:
	@printf '%s\n' \
	  'Kalyx targets:' \
	  '  make host-check       Validate the Linux build host' \
	  '  make fetch-sources    Download and verify LFS sources' \
	  '  make prepare-rootfs   Create the initial Kalyx rootfs skeleton' \
	  '  make prepare-live-config Configure live XFCE defaults in the rootfs' \
	  '  make build-toolchain  Run toolchain recipe phase' \
	  '  make build-base       Run base-system recipe phase' \
	  '  make build-desktop    Run desktop recipe phase' \
	  '  make make-iso         Prepare an ISO tree and run grub-mkrescue'

host-check:
	bash scripts/host-check

fetch-sources:
	bash scripts/fetch-sources

prepare-rootfs:
	bash scripts/prepare-rootfs

prepare-live-config:
	bash scripts/prepare-live-config

build-toolchain:
	bash scripts/build-toolchain

build-base:
	bash scripts/build-base

build-desktop:
	bash scripts/build-desktop

make-iso:
	bash scripts/make-iso
