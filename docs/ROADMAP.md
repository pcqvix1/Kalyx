# Roadmap Kalyx

## Marco 0: Fundacao

- Host-check funcionando.
- Download oficial de fontes LFS.
- Formato de receita e pacote.
- Instalador TUI inicial.
- Esqueleto de ISO.

## Marco 1: LFS bootavel em VM

- Toolchain temporaria.
- Sistema base LFS systemd.
- Kernel Linux configurado para VirtualBox.
- GRUB UEFI.
- Boot ate login em console.
- Status atual: manifestos existem; receitas reais ainda precisam ser
  implementadas.

## Marco 2: Base empacotada

- Converter componentes base para receitas Kalyx.
- Gerar pacotes `.tar.zst`.
- Instalar rootfs a partir dos pacotes.
- Registrar manifestos por pacote.

## Marco 3: Live XFCE

- Xorg/Wayland minimo conforme BLFS.
- XFCE.
- NetworkManager.
- Usuario live `kalyx`.
- Atalho para o instalador.
- Painel reduzido com data/hora e botao Config.

## Marco 4: ISO instalavel

- ISO live bootavel no VirtualBox.
- Instalador TUI testado em disco virtual vazio.
- Reboot no sistema instalado.
- Documentacao de reproducao da ISO.
- Usuario, senha, hostname e timezone perguntados no instalador.
- Sistema instalado sem autologin live e com root bloqueado.
