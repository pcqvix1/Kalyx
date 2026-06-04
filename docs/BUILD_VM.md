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
sudo KALYX_WORKDIR=/home/pedro/kalyx-work bash scripts/build-base
sudo KALYX_WORKDIR=/home/pedro/kalyx-work bash scripts/finalize-base
sudo KALYX_WORKDIR=/home/pedro/kalyx-work bash scripts/make-boot-disk
sudo KALYX_WORKDIR=/home/pedro/kalyx-work bash scripts/build-blfs-base
sudo KALYX_WORKDIR=/home/pedro/kalyx-work bash scripts/build-desktop
sudo KALYX_WORKDIR=/home/pedro/kalyx-work bash scripts/finalize-desktop
```

`finalize-base` prepara a rootfs para boot de terminal: `fstab` placeholder,
hostname, locale, timezone, teclado, `systemd` em modo multi-user, `getty` no
TTY1 e usuario de teste `kalyx` com senha `kalyx`.

`make-boot-disk` gera uma imagem raw UEFI em:

```text
~/kalyx-work/iso/kalyx-0.1.0-terminal-x86_64.img
```

Ela contem uma ESP FAT32, uma raiz ext4, um initramfs de boot, GRUB UEFI
removivel e um `grub.cfg` apontando para o kernel da Kalyx. Essa imagem e o
primeiro teste de boot real em terminal.

O Bloco 2 possui manifestos completos para a base grafica e o desktop reduzido.
`build-blfs-base` compila PAM, sudo, GLib, Polkit, NetworkManager, fontes, Xorg
Libraries, Mesa, Xorg Server, libinput, GTK e LightDM dentro do chroot.
Depois dela, `build-desktop` compila o XFCE reduzido ate Thunar,
xfce4-settings e xfce4-power-manager.

Essas duas fases podem demorar bastante na VM e podem revelar ajustes finos de
receita durante a primeira compilacao real. Se uma receita falhar, leia o log
indicado pelo script em `~/kalyx-work/logs/`.

`finalize-desktop` troca a rootfs para `graphical.target`, habilita LightDM,
garante a sessao `xfce`, cria/atualiza o usuario de teste `kalyx` e remove a
camada live. Para gerar ISO live, rode `prepare-live-config` de novo logo antes
do initramfs/ISO.

Se `finalize-base` avisar que o kernel antigo nao tem suporte de disco embutido,
recompile apenas a receita do kernel:

```bash
sudo KALYX_WORKDIR=/home/pedro/kalyx-work bash scripts/chroot-build-recipe recipes/base/linux-kernel.recipe
```

Depois que o rootfs tiver kernel, systemd, BusyBox para initramfs, XFCE e
finalizacao grafica:

```bash
sudo KALYX_WORKDIR=/home/pedro/kalyx-work bash scripts/prepare-live-config
sudo KALYX_WORKDIR=/home/pedro/kalyx-work bash scripts/build-live-initramfs
sudo KALYX_WORKDIR=/home/pedro/kalyx-work bash scripts/make-iso
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
sudo KALYX_WORKDIR=/home/pedro/kalyx-work bash scripts/build-base
sudo KALYX_WORKDIR=/home/pedro/kalyx-work bash scripts/finalize-base
sudo KALYX_WORKDIR=/home/pedro/kalyx-work bash scripts/make-boot-disk
sudo KALYX_WORKDIR=/home/pedro/kalyx-work bash scripts/build-blfs-base
sudo KALYX_WORKDIR=/home/pedro/kalyx-work bash scripts/build-desktop
sudo KALYX_WORKDIR=/home/pedro/kalyx-work bash scripts/finalize-desktop
sudo KALYX_WORKDIR=/home/pedro/kalyx-work bash scripts/prepare-live-config
sudo KALYX_WORKDIR=/home/pedro/kalyx-work bash scripts/build-live-initramfs
sudo KALYX_WORKDIR=/home/pedro/kalyx-work bash scripts/make-iso
```

