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
  dialog whiptail zstd
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
```

Isso baixa `wget-list`, `md5sums`, pacotes e patches do LFS systemd stable.

## 4. Preparar a raiz da Kalyx

```bash
bash scripts/prepare-rootfs
```

Esse comando cria a identidade inicial da distro no rootfs: `os-release`,
hostname, locale, timezone e o instalador `kalyx-install`.

Para preparar os defaults da ISO live:

```bash
bash scripts/prepare-live-config
```

## 5. Proximos passos

As fases `build-toolchain`, `build-base` e `build-desktop` ja existem como
orquestradores de receitas. Elas passam a compilar pacotes reais conforme as
receitas forem sendo adicionadas.

```bash
bash scripts/build-toolchain
bash scripts/build-base
bash scripts/build-desktop
```
