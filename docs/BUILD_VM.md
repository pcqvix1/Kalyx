# Build da Kalyx na VM Ubuntu

## 1. Criar a VM

No VirtualBox:

- nome: `Kalyx Builder`;
- tipo: Linux / Ubuntu 64-bit;
- EFI habilitado;
- 8 GB RAM;
- 4 CPUs;
- disco VDI dinamico de 160 GB salvo no `D:\`.

Instale Ubuntu normalmente. Depois instale dependencias:

```bash
sudo apt update
sudo apt install -y \
  bash binutils bison build-essential bzip2 coreutils diffutils file findutils \
  gawk gcc g++ gettext git grep gzip m4 make patch perl python3 sed tar texinfo \
  xz-utils wget curl ca-certificates rsync util-linux e2fsprogs dosfstools \
  gdisk parted xorriso grub-pc-bin grub-efi-amd64-bin mtools squashfs-tools \
  dialog whiptail zstd cpio
```

## 2. Clonar e validar

```bash
git clone <url-do-repo> kalyx
cd kalyx
bash scripts/host-check
```

Se o host-check reclamar de espaco, mova o workdir:

```bash
mkdir -p /home/$USER/kalyx-work
KALYX_WORKDIR=/home/$USER/kalyx-work bash scripts/host-check
```

## 3. Baixar fontes oficiais do LFS

```bash
bash scripts/fetch-sources
bash scripts/fetch-blfs-sources
```

Isso baixa `wget-list`, `md5sums`, pacotes e patches do LFS systemd stable, e
tambem a lista/fonte oficial do BLFS systemd stable.

## 4. Preparar a raiz da Kalyx

```bash
bash scripts/prepare-rootfs
bash scripts/prepare-desktop-config
```

Esse comando cria a identidade inicial da distro no rootfs: `os-release`,
hostname, locale, timezone e o instalador `kalyx-install`.
Tambem instala a configuracao XFCE reduzida: painel com data/hora e botao
`Config`.

O teclado padrao da Kalyx e English (US) International:

- console: `KEYMAP=us-acentos`;
- X11/XFCE: `XkbLayout=us`, `XkbVariant=intl`.

Para preparar os defaults da ISO live:

```bash
bash scripts/prepare-live-config
```

## 5. Proximos passos

As fases abaixo ja tem manifestos de ordem. Elas exigem que as receitas reais
existam com os mesmos nomes listados nos manifestos. Quando uma receita ainda
nao existe, o runner para naquele ponto e informa qual e a proxima a criar.

```bash
bash scripts/build-toolchain
sudo KALYX_WORKDIR=/home/pedro/kalyx-work bash scripts/prepare-chroot
sudo KALYX_WORKDIR=/home/pedro/kalyx-work bash scripts/build-chroot-temp
bash scripts/build-base
bash scripts/build-blfs-base
bash scripts/build-desktop
```

Depois que o rootfs tiver kernel, systemd, BusyBox para initramfs e XFCE:

```bash
bash scripts/build-live-initramfs
bash scripts/make-iso
```

Comando até agora usados na ordem, usados dentro da pasta kalyx:

```bash
bash scripts/host-check 
bash scripts/fetch-sources 
bash scripts/prepare-rootfs 
bash scripts/prepare-desktop-config 
bash scripts/prepare-live-config 
bash scripts/build-toolchain
sudo KALYX_WORKDIR=/home/pedro/kalyx-work bash scripts/prepare-chroot
sudo KALYX_WORKDIR=/home/pedro/kalyx-work bash scripts/build-chroot-temp
bash scripts/build-base
```


