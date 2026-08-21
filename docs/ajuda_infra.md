# 🛠️ Arquitetura & Comandos Úteis de Infraestrutura (Mautic BJ Sports)

Documentação de arquitetura de software, mapeamento de portas e comandos operacionais rápidos para sustentação do **Mautic**.

---

## 🏗️ Arquitetura da Stack

```text
[ Cliente / Browser ] ───► [ Mautic Web (Porta 8080) ]
                               │      │
           ┌───────────────────┘      └───────────────────┐
           ▼                                              ▼
[ MariaDB (Porta 3306) ]                      [ Redis (Porta 6379) ]
(Persistência Mautic)                         (Filas & Cache)
```

---

## 🔌 Portas e Serviços

| Serviço | Container | Porta Externa | Porta Interna | Finalidade |
| :--- | :--- | :--- | :--- | :--- |
| Mautic Web | `mautic_web` | `8080` | `80` | Painel web e Webhooks do Mautic |
| MariaDB | `mautic_db` | - | `3306` | Banco de dados MySQL/MariaDB |
| Redis | `mautic_redis` | - | `6379` | Cache de sessão e filas de envio |

---

## ⚡ Comandos Operacionais Rápidos

### 1. Limpar cache do Mautic
```bash
docker compose exec mautic_web php /var/www/html/bin/console cache:clear
```

### 2. Disparar filas de e-mail pendentes
```bash
docker compose exec mautic_web php /var/www/html/bin/console mautic:emails:send
```

### 3. Atualizar segmentos de contatos
```bash
docker compose exec mautic_web php /var/www/html/bin/console mautic:segments:update
```

### 4. Processar eventos de campanhas
```bash
docker compose exec mautic_web php /var/www/html/bin/console mautic:campaigns:trigger
```
