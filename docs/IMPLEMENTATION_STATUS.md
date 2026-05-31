# Status de implementacao

## Implementado no repositorio

- Validacao de host.
- Download de fontes LFS.
- Download de fontes BLFS.
- Preparacao de rootfs inicial.
- Configuracao XFCE reduzida em `/etc/skel`.
- Script `kalyx-time-config` para NTP/timezone/hora manual.
- Instalador TUI com disco, hostname, usuario, senha e timezone.
- Remocao de autologin live no sistema instalado.
- Scripts de mount/chroot.
- Initramfs live baseado em BusyBox, squashfs e overlayfs.
- Manifestos de ordem para toolchain, base, BLFS minimo e XFCE.
- Executor `scripts/lfs-build-recipe` para receitas LFS.
- Preparacao de chroot conforme capitulo 7 do LFS.
- Executor `scripts/chroot-build-recipe` para receitas executadas dentro do chroot.
- Primeiras receitas reais da toolchain:
  - `binutils-pass1`;
  - `gcc-pass1`;
  - `linux-api-headers`;
  - `glibc`;
  - `libstdcxx-pass1`;
  - temporarias de `m4` ate `xz`;
  - `binutils-pass2`;
  - `gcc-pass2`.
- Receitas chroot temporarias:
  - Gettext;
  - Bison;
  - Perl;
  - Python;
  - Texinfo;
  - Util-linux.
- Primeiras receitas finais do sistema base:
  - Man-pages;
  - Iana-Etc;
  - Glibc final com locales `C.UTF-8`, `en_US.UTF-8` e `pt_BR.UTF-8`;
  - Zlib;
  - Bzip2;
  - Xz;
  - Lz4;
  - Zstd;
  - File;
  - Readline;
  - Pcre2;
  - M4;
  - Bc;
  - Flex;
  - Tcl;
  - Expect;
  - DejaGNU;
  - Pkgconf;
  - Binutils final;
  - GMP;
  - MPFR;
  - MPC;
  - Attr;
  - Acl;
  - Libcap;
  - Libxcrypt;
  - Shadow;
  - GCC final;
  - Ncurses;
  - Sed;
  - Psmisc;
  - Gettext;
  - Bison;
  - Grep;
  - Bash;
  - Libtool;
  - GDBM;
  - Gperf;
  - Expat;
  - Inetutils;
  - Less;
  - Perl;
  - XML::Parser;
  - Intltool;
  - Autoconf;
  - Automake;
  - OpenSSL;
  - Libelf from Elfutils;
  - Libffi;
  - Sqlite;
  - Python;
  - Flit-Core;
  - Packaging;
  - Wheel;
  - Setuptools;
  - Ninja;
  - Meson;
  - Kmod;
  - Coreutils;
  - Check;
  - Diffutils;
  - Gawk;
  - Findutils;
  - Groff;
  - GRUB EFI;
  - Gzip;
  - IPRoute2;
  - Kbd;
  - Libpipeline;
  - Make;
  - Patch;
  - Tar;
  - Texinfo;
  - Vim;
  - MarkupSafe;
  - Jinja2;
  - Systemd;
  - D-Bus;
  - Man-DB;
  - Procps-ng;
  - Util-linux;
  - E2fsprogs;
  - Linux kernel;
  - BusyBox for initramfs.

## Ainda nao implementado

- Receitas reais de todos os pacotes LFS.
- Receitas reais dos pacotes BLFS/XFCE.
- Configuracao final do kernel.
- BusyBox compilado para o initramfs.
- Teste de boot real em VirtualBox.
- ISO final validada.

## Proxima tarefa real

Rodar `bash scripts/build-toolchain` dentro da VM. Ele deve construir as
receitas ja implementadas da cross-toolchain e terminar o manifesto
`recipes/toolchain/manifest`. Depois, como root, rodar:

```bash
sudo KALYX_WORKDIR=$HOME/kalyx-work bash scripts/prepare-chroot
sudo KALYX_WORKDIR=$HOME/kalyx-work bash scripts/build-chroot-temp
```

A proxima fronteira apos isso e iniciar as receitas finais do sistema base no
capitulo 8 do LFS:

```bash
sudo KALYX_WORKDIR=$HOME/kalyx-work bash scripts/build-base
```

Essa fase agora cobre todo o manifesto `recipes/base/manifest`. A proxima etapa
e executar/corrigir o build real na VM e entao adicionar os scripts de
configuracao final de sistema, fstab, GRUB instalado no disco e teste de boot.
