# 💾 Política de Backup 3-2-1 (Mautic BJ Sports)

Definição da estratégia de backup e recuperação de desastres para o ecossistema **Mautic**.

---

## 🎯 Regra 3-2-1

- **3 Cópias**: 1 em Produção (MariaDB Volume), 1 Cópia Local compactada (`/var/backups/mautic`), 1 Cópia Offsite (Cloud / S3 / Rclone).
- **2 Meios Diferentes**: Disco local de servidor + Storage de Nuvem criptografado.
- **1 Cópia Offsite**: Sincronizada via script Rclone diário.

---

## 📜 Automação via Shell Script (`infra/backup_mautic.sh`)

O script `infra/backup_mautic.sh` executa o dump do banco de dados MariaDB, empacota as mídias e realiza a rotação mantendo backups dos últimos 7 dias.

### Agendamento no Crontab da Máquina
```bash
0 3 * * * /bin/bash /home/vier/Documentos/Code/Fernando\ vier/Mautic-vier/infra/backup_mautic.sh >> /var/log/mautic_backup.log 2>&1
```
