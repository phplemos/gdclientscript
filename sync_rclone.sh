#!/bin/bash

# Diretório a ser monitorado
DIRETORIO_LOCAL="/home/phplemos/Drive"

# Nome do remoto configurado no rclone
REMOTE_NAME="remote"

# Caminho no remoto onde os arquivos serão sincronizados
REMOTE_PATH="Computador Pedro/remoto"

# Comando para monitorar o diretório e processar eventos
fswatch -0 -r --event Updated --event Created --event Removed "$DIRETORIO_LOCAL" | while IFS= read -r -d '' arquivo_modificado; do
    echo "Arquivo modificado: $arquivo_modificado"

    # Sincroniza o diretório local com o remoto
    # rclone sync "$DIRETORIO_LOCAL" "$REMOTE_NAME:$REMOTE_PATH" --progress

    # Opcional: Sincroniza do remoto para o local
    # rclone sync "$REMOTE_NAME:$REMOTE_PATH" "$DIRETORIO_LOCAL" --progress
done
