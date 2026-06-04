# Status de implementacao

## Implementado no repositorio

- Validacao de host.
- Download de fontes LFS.
- Download de fontes BLFS.
- Preparacao de rootfs inicial.
- Configuracao XFCE reduzida em `/etc/skel`.
- Finalizacao grafica com `graphical.target`, LightDM, sessao XFCE e usuario de teste.
- Script `kalyx-time-config` para NTP/timezone/hora manual.
- Instalador TUI com disco, hostname, usuario, senha e timezone.
- Instalador remove o usuario live antes de criar o usuario definido na instalacao.
- Remocao de autologin live no sistema instalado.
- Scripts de mount/chroot.
- Finalizacao da base para boot terminal.
- Geracao de imagem raw UEFI de teste terminal.
- Initramfs live baseado em BusyBox, squashfs e overlayfs.
- Initramfs de boot terminal baseado em BusyBox, UUID de root e modulos do kernel.
- Inicio real do Bloco 2 BLFS:
  - libtasn1;
  - make-ca;
  - p11-kit;
  - NSPR;
  - NSS;
  - Linux-PAM;
  - Shadow reconstruido com PAM;
  - systemd reconstruido com PAM/logind;
  - Sudo com PAM e permissao administrativa para o grupo `wheel`;
  - duktape;
  - GLib com GObject Introspection;
  - Polkit;
  - D-Bus reconstruido para a camada BLFS;
  - libndp;
  - NetworkManager minimo para ethernet/VM;
  - libpng com APNG;
  - FreeType;
  - Fontconfig;
  - DejaVu fonts;
  - Noto Sans fonts;
  - libdrm;
  - util-macros;
  - xorgproto;
  - libXau;
  - libXdmcp;
  - xcb-proto;
  - libxcb;
  - xcb-util;
  - xcb-util-image;
  - xcb-util-keysyms;
  - xcb-util-renderutil;
  - xcb-util-wm;
  - xcb-util-cursor;
  - Xorg Libraries conforme lista `lib-7.md5` do BLFS 13.0;
  - Mako;
  - PyYAML;
  - Mesa minimo para X11, sem Vulkan/LLVM por enquanto, com drivers Gallium para VM/software;
  - xbitmaps;
  - Xorg Applications conforme lista `app-7.md5` do BLFS 13.0;
  - libxcvt;
  - Pixman;
  - font-util;
  - xkeyboard-config;
  - libepoxy;
  - Xorg Server com glamor e diretorio XKB em `/var/lib/xkb`;
  - libxml2;
  - libgudev;
  - libevdev;
  - mtdev;
  - libinput;
  - xf86-input-libinput;
  - libxkbcommon;
  - gsettings-desktop-schemas;
  - shared-mime-info;
  - FriBidi;
  - HarfBuzz;
  - FreeType reconstruido com HarfBuzz;
  - Fontconfig reconstruido apos HarfBuzz/FreeType;
  - Cairo;
  - Pango;
  - at-spi2-core;
  - GdkPixbuf;
  - hicolor-icon-theme;
  - GTK 3;
  - libgpg-error;
  - libgcrypt;
  - libxslt;
  - lxml;
  - docbook-xml;
  - itstool com patch para lxml;
  - ISO Codes;
  - libxklavier;
  - libxfce4util;
  - Xfconf;
  - startup-notification;
  - libxfce4ui;
  - Exo;
  - LightDM com lightdm-gtk-greeter, PAM, diretorios de runtime e unit systemd.
- Manifesto real do desktop XFCE reduzido:
  - hwdata;
  - libdisplay-info;
  - Garcon;
  - libwnck;
  - xfce4-dev-tools;
  - libxfce4windowing;
  - xfce4-panel;
  - xfwm4;
  - desktop-file-utils;
  - AccountsService;
  - polkit-gnome;
  - libnotify;
  - xfdesktop;
  - xfce4-session;
  - CMake;
  - fast_float;
  - fmt;
  - ICU;
  - simdutf;
  - VTE;
  - xfce4-terminal;
  - LXDE icon theme;
  - Thunar;
  - libusb;
  - UPower;
  - xfce4-settings;
  - xfce4-power-manager.
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

- Execucao completa do build BLFS/XFCE na VM.
- Validacao real do login grafico em VirtualBox.
- ISO final validada.
- Ajustes finais do instalador/ISO depois que o desktop estiver bootando.

## Proxima tarefa real

Depois que a imagem terminal ja boota ate login, executar o Bloco 2 completo:

```bash
sudo KALYX_WORKDIR=/home/pedro/kalyx-work bash scripts/build-blfs-base
sudo KALYX_WORKDIR=/home/pedro/kalyx-work bash scripts/build-desktop
sudo KALYX_WORKDIR=/home/pedro/kalyx-work bash scripts/finalize-desktop
```

O runner deve compilar todo o manifesto `blfs-base` e depois todo o manifesto
`desktop`. O criterio de sucesso deste sub-marco e ter:

```text
PAM -> NetworkManager -> Fontconfig/fonts -> libdrm -> Xorg protocol/XCB base -> Xorg Libraries -> Mesa -> Xorg Server -> libinput -> GTK3 -> LightDM
LightDM -> Garcon -> libwnck -> libxfce4windowing -> xfce4-panel -> xfwm4
xfdesktop -> xfce4-session -> polkit-gnome auth agent
cmake -> VTE -> xfce4-terminal -> Thunar -> xfce4-settings -> xfce4-power-manager
```
