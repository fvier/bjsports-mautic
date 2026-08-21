# 🚚 Guia de Migração & Onboarding (Mautic BJ Sports)

Este guia orienta os desenvolvedores sobre a clonagem, configuração de ambiente e onboarding do projeto **bjsports-mautic** em novos servidores ou máquinas de desenvolvimento.

---

## 📋 Pré-requisitos

- Docker & Docker Compose v2+
- Git pré-configurado com chaves SSH habilitadas no GitHub (`git@github.com:fvier/bjsports-mautic.git`)
- Acesso à API de Envio de E-mails (SendGrid, Mailgun ou Amazon SES)

---

## 📥 Passo 1: Clonar o Repositório via SSH

```bash
git clone git@github.com:fvier/bjsports-mautic.git
cd bjsports-mautic
```

---

## ⚙️ Passo 2: Configuração de Variáveis de Ambiente

Copie o modelo oficial e edite com os dados locais/homologação:

```bash
cp .env.example .env
nano .env
```

---

## 🚀 Passo 3: Inicialização dos Containers

Suba a stack Mautic + MariaDB + Redis:

```bash
docker compose up -d
```

Verifique o status dos containers:

```bash
docker compose ps
```

---

## 🧪 Passo 4: Validação do Painel Mautic

Acesse no navegador: `http://localhost:8080` (ou URL configurada no `MAUTIC_URL`). Logar com as credenciais cadastradas no `.env`.
