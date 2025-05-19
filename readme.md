# GDClientScript

Um script em shell cujo o objetivo é ser um client simples para Google Drive no Linux utilizando `Rclone` e `Fswatch`.

## Visão Geral

Este projeto oferece uma interface shell para sincronização automática de arquivos entre um diretório local e o Google Drive, usando `rclone` para comunicação com o Drive e `fswatch` para monitorar alterações em tempo real.

## Requisitos

- [rclone](https://rclone.org/downloads/)
- [fswatch](https://emcrisostomo.github.io/fswatch/)
- Bash (ou outro shell compatível)

## Instalação

1. Clone o repositório:

   ```bash
   git clone https://github.com/seu-usuario/gdrive-shell-client.git
   cd gdrive-shell-client
   ```


## Features do GDClientScript
    ✅ Sincronização automática em tempo real
    Usa fswatch para monitorar alterações em tempo real em um diretório local e sincronizar automaticamente com o Google Drive via rclone.

    ✅ Leve e sem dependências pesadas
    Construído apenas com shell script e duas dependências externas leves (rclone, fswatch).

    ✅ Customização simples
    Basta editar o script para mudar diretórios monitorados, configurar múltiplos remotes, ou ajustar flags do rclone.

    