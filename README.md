# Kalyx

Kalyx e uma distro Linux x86_64 UEFI feita do zero, usando Linux From Scratch
como base educacional e tecnica. O alvo inicial e uma ISO live com XFCE e um
instalador TUI simples.

## Estado atual

Este repositorio contem a fundacao do projeto:

- validacao do host de build;
- download das fontes oficiais do LFS systemd stable;
- formato inicial de receitas e pacotes `.tar.zst`;
- instalador TUI inicial com fluxo UEFI/ext4;
- esqueleto para montagem de ISO.

O build pesado deve rodar dentro de uma VM Ubuntu no VirtualBox, com disco no
`D:\`, nao diretamente no Windows nem em pasta compartilhada.

## Ambiente recomendado

- VirtualBox com uma VM Ubuntu 24.04 ou mais recente
- Disco virtual da VM no `D:\`, com pelo menos 160 GB
- 8 GB RAM e 4 CPUs para a VM
- Boot UEFI habilitado na VM

Dentro da VM:

```bash
sudo apt update
sudo apt install -y \
  bash binutils bison build-essential bzip2 coreutils diffutils file findutils \
  gawk gcc g++ gettext git grep gzip m4 make patch perl python3 sed tar texinfo \
  xz-utils wget curl ca-certificates rsync util-linux e2fsprogs dosfstools \
  gdisk parted xorriso grub-pc-bin grub-efi-amd64-bin mtools squashfs-tools \
  dialog whiptail zstd
```

Depois clone o repo e rode:

```bash
git clone <url-do-repo> kalyx
cd kalyx
bash scripts/host-check
bash scripts/fetch-sources
```

## Layout

```text
config/        Configuracao padrao da Kalyx e do build
docs/          Guias de ambiente, arquitetura e roadmap
installer/     Instalador TUI da ISO live
recipes/       Receitas de pacotes
scripts/       Automacao do build, pacotes, fontes e ISO
```

## Filosofia da v1

- primeiro fazer funcionar em VM;
- preferir scripts pequenos, auditaveis e reprodutiveis;
- seguir LFS/BLFS systemd stable antes de inventar divergencias;
- empacotar artefatos simples antes de criar um gerenciador de pacotes completo;
- manter operacoes destrutivas atras de confirmacoes claras.

