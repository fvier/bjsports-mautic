# 📋 Registro de Incidentes & Postmortem (Mautic BJ Sports)

> [!IMPORTANT]
> **Alimentação Incremental:** Novos registros devem ser obrigatoriamente adicionados no topo desta tabela, preservando o histórico para auditoria.

---

| Data | Incidente | Causa Raiz | Ação Corretiva | Status |
| :--- | :--- | :--- | :--- | :--- |
| 2026-08-21 | Fila de e-mails retida | CronJob de disparo congelado por timeout PHP | Reconfiguração do container Mautic Web com limites de memória ajustados | Resolvido |
| 2026-07-30 | Falha na importação de contatos CSV | Codificação de arquivo fora do padrão UTF-8 | Validação no script Python de importação antes do envio via API | Resolvido |
