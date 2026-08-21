#!/usr/bin/env bash
# ==============================================================================
# Script de Backup Idempotente do Mautic BJ Sports
# ==============================================================================
set -euo pipefail

BACKUP_DIR="${BACKUP_DIR:-/var/backups/mautic}"
TIMESTAMP=$(date +'%Y%m%d_%H%M%S')
MYSQL_CONTAINER="${MYSQL_CONTAINER:-mautic_db}"
MYSQL_DATABASE="${MYSQL_DATABASE:-mautic}"
MYSQL_USER="${MYSQL_USER:-mauticuser}"
MYSQL_PASSWORD="${MYSQL_PASSWORD:-mauticpass}"
RCLONE_REMOTE="${RCLONE_REMOTE_PATH:-bjsports-backup:mautic}"

mkdir -p "${BACKUP_DIR}"

echo "[INFO] Iniciando dump do banco de dados Mautic (${MYSQL_DATABASE})..."
DUMP_FILE="${BACKUP_DIR}/mautic_db_${TIMESTAMP}.sql.gz"

docker exec "${MYSQL_CONTAINER}" mysqldump -u"${MYSQL_USER}" -p"${MYSQL_PASSWORD}" "${MYSQL_DATABASE}" | gzip > "${DUMP_FILE}"

echo "[INFO] Dump concluído com sucesso: ${DUMP_FILE}"

# Envio offsite via Rclone se configurado
if command -v rclone &> /dev/null; then
    echo "[INFO] Sincronizando backup offsite via Rclone..."
    rclone copy "${DUMP_FILE}" "${RCLONE_REMOTE}"
fi

# Rotação local: remove backups com mais de 7 dias
find "${BACKUP_DIR}" -name "mautic_db_*.sql.gz" -mtime +7 -delete

echo "[SUCCESS] Processo de backup do Mautic finalizado!"
