#!/bin/bash

# Local do script de sincronização
SYNC_CLOUD="$HOME/scripts/sync_cloud.sh"

# Arquivo que bloqueia execução dupla do script
LOCKFILE="/tmp/sync_cloud.lock"

# Verifica se o arquivo está em execução, caso sim, não permite execução
if [ -e ${LOCKFILE} ] && kill -0 `cat ${LOCKFILE}`; then
    echo "O script ja está em execução"
    exit 1
fi

# Certifica de que o arquivo de bloqueio é removido quando sairmos e então o reivindica
trap "rm -f ${LOCKFILE};exit" INT TERM EXIT
echo $$ >> ${LOCKFILE}


${SYNC_CLOUD}


# Remove o arquivo de lock ao final
rm -f ${LOCKFILE}
