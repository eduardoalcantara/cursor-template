# prompts/

Prompts reutilizáveis, colas e instruções mestre para o Cursor — **e** handoff **CCIA** (Conversas com o Agente) para continuidade multi-máquina via Git.

Os prompts reutilizáveis **não substituem** `flow.md` nem `.cursorrules`. O CCIA **não substitui** `status.md` / `timeline.md` / `.prompt-status`.

## Conteúdo típico

### Colas reutilizáveis
- Colas de bootstrap
- Prompts de revisão
- Prompts de grupo e de fluxo

### CCIA — handoff por prompt relevante

Nome (hífen; nunca underscore):

```text
YYYY-MM-DD-NN-<hostname>-<resumo-curto>.md
```

| Parte | Regra |
|---|---|
| `YYYY-MM-DD` | Data local da sessão |
| `NN` | `current_prompt_number` de `.prompt-status` (zero à esquerda se o projeto já usar) |
| `hostname` | Hostname curto da máquina |
| `resumo-curto` | 3–6 palavras kebab-case, sem acentos |

Gravar após entrega/decisão/diagnóstico/alteração. **Exceção:** pedido exclusivo de commit/push → não criar CCIA.

Conteúdo mínimo: título `# CCIA — …`, data/hora + hostname, pedido, o que foi feito, arquivos, validações, pendências, próximo passo. Sem segredos/PII.

### Handoff diário (abrir primeiro após `git pull` noutro PC)

```text
YYYY-MM-DD-handoff-<hostname>.md
```

Estado atual, decisões abertas, bloqueios, 3–5 bullets de "onde paramos", lista dos CCIA do dia, próximo passo único.

Norma completa: `spec-project-bootstrap.md` §5.11.
