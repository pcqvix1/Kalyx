# Arquitetura inicial

## Base

- LFS systemd stable como referencia do sistema base.
- BLFS systemd stable como referencia para rede, grafico e XFCE.
- Arquitetura v1: x86_64 UEFI.

## Diretorios de build

Por padrao:

```text
$HOME/kalyx-work/
  sources/   fontes e patches baixados
  build/     arvores temporarias de compilacao
  tools/     ferramentas temporarias de bootstrap
  rootfs/    raiz da imagem Kalyx
  packages/  pacotes .tar.zst
  iso/       arvore e ISO final
  logs/      logs por pacote/fase
```

Nao use `/mnt/c`, `/mnt/d` ou pasta compartilhada do VirtualBox para compilar o
LFS. O build precisa de semantica Linux confiavel de permissoes, links e donos.

## Pacotes

A v1 usa pacotes `.tar.zst` simples:

- conteudo do pacote e extraido diretamente no rootfs;
- metadados ficam em `/var/lib/kalyx/pkg/<nome>`;
- o foco e reproducibilidade e auditoria, nao resolucao automatica completa de
  dependencias.

## Instalador

O instalador v1 e TUI e destrutivo por design:

- suporta apenas UEFI;
- apaga o disco escolhido;
- cria ESP FAT32 de 512 MiB;
- usa raiz ext4;
- cria swapfile de 2 GiB;
- instala GRUB UEFI.

Ele exige confirmacao digitada `KALYX` antes de apagar qualquer disco.

## ISO live

A configuracao live inicial prepara:

- autologin do usuario `kalyx` no LightDM, quando LightDM/XFCE estiverem
  instalados;
- autologin em TTY1 como fallback;
- launcher grafico `Instalar Kalyx`;
- sudo sem senha apenas para `/usr/sbin/kalyx-install` no usuario live.

## Interface instalada

A configuracao padrao do usuario instalado vem de `/etc/skel`:

- painel XFCE reduzido;
- relogio com dia, data e hora;
- launcher `Config`;
- script `kalyx-time-config`, que usa `timedatectl` para NTP, timezone e hora
  manual, abrindo em terminal grafico quando nao houver backend grafico de
  dialogo instalado;
- autorizacao via Polkit para usuarios no grupo `wheel`.

## Manifestos

Cada fase pode ter um arquivo `manifest` dentro de `recipes/<fase>`. Quando ele
existe, `scripts/run-recipe-phase` executa as receitas exatamente nessa ordem e
falha se alguma receita estiver faltando.
