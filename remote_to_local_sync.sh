#!/bin/bash

# Arquivo que bloqueia execução dupla do script
LOCKFILE="/tmp/gdclientscript.lock"

# Arquivo que armazena o log de DIFF
LOG_DIFF="/tmp/gdclientscript_diffs.log"

# Diretório a ser atualizado || No meu caso é o Gdrive, aqui voce coloca a pasta que deseja sincronizar
DIRETORIO_LOCAL="$HOME/GDrive"

# Nome do remoto configurado no rclone
REMOTE_NAME="drive"

# Caminho no remoto onde os arquivos serão sincronizados
REMOTE_PATH="/Computador Pedro/Documentos"

###########################################################################

# Verifica se o arquivo está em execução, caso sim, não permite execução
if [ -e ${LOCKFILE} ] && kill -0 $(cat ${LOCKFILE}); then
    echo "Ja tem uma sincronização em execução"
    exit 1
fi

echo "Verificando se há alterações no remoto"

rclone check "$REMOTE_NAME:$REMOTE_PATH" "$DIRETORIO_LOCAL" --one-way --differ - > "$LOG_DIFF" 2>/dev/null

if [ -s "$LOG_DIFF"];then
    echo "Diferenças detectadas. Iniciando Sync"
    # Certifica de que o arquivo de bloqueio é removido quando sairmos 
    trap "rm -f ${LOCKFILE};exit" INT TERM EXIT
    # Bloqueia o script de executar novamente
    echo $$ >>${LOCKFILE}
    # Incia sincronização
    sync_remote_to_local()    
else
    echo "Nenhuma alteração encontrada"
    exit
fi

# Sincroniza do remoto para o local
sync_remote_to_local(){
    rclone sync "$REMOTE_NAME:$REMOTE_PATH" "$DIRETORIO_LOCAL" --progress
    # Libera script
    rm -f ${LOCKFILE}
    echo "Processo de atualização finalizado. Tudo OK!"
}

