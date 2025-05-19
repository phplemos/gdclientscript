#!/bin/bash

############# GDClientscript no Linux V1.0 #############

# Author: Pedro Henrique Pinheiro
# GitHub: https://github.com/phplemos
# Linkedin: http://linkedin/in/phplemos

############################### DESCRIPTION ###############################

# Um script em shell cujo o objetivo é ser um client simples para  o
# Google Drive no Linux utilizando `Rclone` e `Fswatch`.

############################## CONFIGURATIONS ##############################

# Arquivo que bloqueia execução dupla do script
LOCKFILE="/tmp/gdclientscript.lock"
# Diretório a ser monitorado
DIRETORIO_LOCAL="$HOME/LLdriev"
# Nome do remoto configurado no rclone
REMOTE_NAME="drive"
# Caminho no remoto onde os arquivos serão sincronizados
REMOTE_PATH="Computador Pedro/remoto"

###########################################################################
# Verifica se o arquivo está em execução, caso sim, não permite execução
# Certifica de que o arquivo de bloqueio é removido quando sairmos e então o reivindica
trap "rm -f ${LOCKFILE};exit" INT TERM EXIT
echo $$ >>${LOCKFILE}

# Comando para monitorar o diretório e processar eventos
fswatch -1 -r --event Updated --event Created --event Removed "$DIRETORIO_LOCAL" | while IFS= read -r -d '' arquivo_modificado; do
    echo "Arquivo modificado: $arquivo_modificado"

    if [ -e ${LOCKFILE} ] && kill -0 $(cat ${LOCKFILE}); then
        echo "O script ja está em execução"
    fi

    # Sincroniza o diretório local com o remoto
    # rclone sync "$DIRETORIO_LOCAL" "$REMOTE_NAME:$REMOTE_PATH" --progress

    # Opcional: Sincroniza do remoto para o local
    # rclone sync "$REMOTE_NAME:$REMOTE_PATH" "$DIRETORIO_LOCAL" --progress
done

# Remove o arquivo de lock ao final
rm -f ${LOCKFILE}
