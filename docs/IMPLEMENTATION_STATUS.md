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
- Finalizacao da base para boot terminal.
- Geracao de imagem raw UEFI de teste terminal.
- Initramfs live baseado em BusyBox, squashfs e overlayfs.
- Initramfs de boot terminal baseado em BusyBox, UUID de root e modulos do kernel.
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
- Conversao/fluxo de teste da imagem terminal no VirtualBox do host.
- Teste de boot real em VirtualBox.
- ISO final validada.

## Proxima tarefa real

Depois que `scripts/build-base` concluiu na VM, finalizar a base e gerar a
primeira imagem UEFI de teste terminal:

```bash
sudo KALYX_WORKDIR=/home/pedro/kalyx-work bash scripts/finalize-base
sudo KALYX_WORKDIR=/home/pedro/kalyx-work bash scripts/make-boot-disk
```

O criterio de sucesso deste marco e bootar a imagem em modo UEFI e chegar em:

```text
GRUB -> kernel Kalyx -> systemd -> login terminal
```

Login de teste da imagem terminal: `kalyx` / `kalyx`.
