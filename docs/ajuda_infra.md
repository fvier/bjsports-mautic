# 🛠️ Arquitetura & Comandos Úteis de Infraestrutura (Mautic BJ Sports)

Documentação de arquitetura de software, mapeamento de portas, comandos operacionais rápidos e laboratório **Terraform & Docker**.

---

## 🏗️ Arquitetura da Stack & Laboratório Terraform

```text
[ Cliente / Browser ] ───► [ Mautic Web (Porta 8080) ]
                               │      │
           ┌───────────────────┘      └───────────────────┐
           ▼                                              ▼
[ MariaDB (Porta 3306) ]                      [ Redis (Porta 6379) ]
(Persistência Mautic)                         (Filas & Cache)

──────────────────────────────────────────────────────────────────

┌────────────────────────────────────────────────────────────────┐
│               Laboratório Terraform (`infra/terraform`)         │
│  ┌──────────────────┐  ┌──────────────────┐  ┌──────────────┐ │
│  │ PostgreSQL 16    │  │ Redis 7          │  │ Adminer Web  │ │
│  │ (Porta 5432)     │  │ (Porta 6379)     │  │ (Porta 8090) │ │
│  └──────────────────┘  └──────────────────┘  └──────────────┘ │
└────────────────────────────────────────────────────────────────┘
```

---

## 🧪 Laboratório Local com Terraform & Docker

O repositório disponibiliza um ambiente declarativo gerenciado via **Terraform** localizado em `infra/terraform/`.

### 1. Inicializar e aplicar o Laboratório
```bash
cd infra/terraform
terraform init
terraform plan
terraform apply -auto-approve
```

### 2. Acessar o banco PostgreSQL do Laboratório
- **Host**: `localhost`
- **Porta**: `5434`
- **Banco**: `bjsports_lab_db`
- **Usuário**: `bjsports_admin`
- **Senha**: `bjsports_lab_secret_2026`
- **Adminer Web**: Accessar `http://localhost:8090` (Selecione PostgreSQL, Server `bjsports_postgres_lab`).

### 3. Destruir o Laboratório
```bash
cd infra/terraform
terraform destroy -auto-approve
```

---

## 🔌 Portas e Serviços

| Serviço | Container | Porta Externa | Porta Interna | Finalidade |
| :--- | :--- | :--- | :--- | :--- |
| Mautic Web | `mautic_web` | `8080` | `80` | Painel web e Webhooks do Mautic |
| MariaDB | `mautic_db` | - | `3306` | Banco de dados MySQL/MariaDB |
| Redis Mautic | `mautic_redis` | - | `6379` | Cache de sessão e filas de envio |
| **PostgreSQL Lab** | `bjsports_postgres_lab` | `5432` | `5432` | Banco PostgreSQL do Laboratório |
| **Redis Lab** | `bjsports_redis_lab` | `6379` | `6379` | Cache Redis do Laboratório |
| **Adminer Lab** | `bjsports_adminer_lab` | `8090` | `8080` | Interface Web para inspeção SQL |

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
