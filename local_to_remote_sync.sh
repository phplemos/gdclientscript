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
# Diretório a ser monitorado || No meu caso é o Gdrive, aqui voce coloca a pasta que deseja sincronizar
DIRETORIO_LOCAL="$HOME/GDrive"
# Nome do remoto configurado no rclone
REMOTE_NAME="drive"
# Caminho no remoto onde os arquivos serão sincronizados
REMOTE_PATH="/Computador Pedro/Documentos"

###########################################################################

# Comando para monitorar o diretório e processar eventos
fswatch -1 -r --event Updated --event Created --event Removed "$DIRETORIO_LOCAL" | while IFS= read -r -d '' arquivo_modificado; do

    # Verifica se o arquivo está em execução, caso sim, não permite execução
    if [ -e ${LOCKFILE} ] && kill -0 $(cat ${LOCKFILE}); then
        echo "Ja tem uma sincronização em execução"
    else
        # Certifica de que o arquivo de bloqueio é removido quando sairmos 
        trap "rm -f ${LOCKFILE};exit" INT TERM EXIT
        # Bloqueia o script de executar novamente
        echo $$ >>${LOCKFILE}
        sync_local_to_remote()
    fi
    
done

# Sincroniza o diretório local com o remoto
sync_local_to_remote(){
    rclone sync "$DIRETORIO_LOCAL" "$REMOTE_NAME:$REMOTE_PATH" --progress
    rm -f ${LOCKFILE}
}
