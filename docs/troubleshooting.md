# 🔧 Troubleshooting & Solução de Problemas (Mautic BJ Sports)

> [!IMPORTANT]
> **Alimentação Incremental:** Adicione novas soluções de erros no início das seções mantendo os itens anteriores intactos.

---

## 🛑 1. Container `mautic_web` reiniciando ou com erro 500

### Sintoma
Ao tentar acessar o painel do Mautic, o navegador exibe erro 500 ou mensagem de permissão negada.

### Solução
Ajustar permissões do diretório `/var/www/html/var/cache` e limpar o cache manualmente:

```bash
docker compose exec mautic_web chown -R www-data:www-data /var/www/html/var/cache
docker compose exec mautic_web php /var/www/html/bin/console cache:clear
```

---

## 🛑 2. E-mails de campanhas não são disparados

### Sintoma
Os contatos entram nos segmentos, mas as filas de e-mail não são processadas.

### Solução
Verificar se o parâmetro `MAUTIC_RUN_CRON_JOBS=true` está ativo no `.env` e executar o comando de disparo forçado:

```bash
docker compose exec mautic_web php /var/www/html/bin/console mautic:emails:send --force
```
