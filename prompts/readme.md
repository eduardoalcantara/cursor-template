# prompts/

Prompts reutilizáveis (colas) e **CCIA** (Conversas com o Agente) para continuidade multi-máquina via Git.

Colas **não** substituem `flow.md` / `.cursorrules`. CCIA **não** substitui `status.md` / `timeline.md` / `.prompt-status`.

## Colas oficiais do template

| Arquivo | Uso |
|---|---|
| `so-investigar.md` | Só investigar; não editar |
| `revisar-diff.md` | Revisar alterações / diff |
| `fechar-sessao-handoff.md` | Fechar sessão e gravar handoff diário |
| `validar-estrutura.md` | Rodar e interpretar `validate-structure` |

Specs opt-in (incl. personalizar projeto): `specs/optional/`.

## CCIA — gravar após prompt relevante

```text
YYYY-MM-DD-NN-<hostname>-<resumo-curto>.md
```

| Parte | Regra |
|---|---|
| `YYYY-MM-DD` | Data local |
| `NN` | `current_prompt_number` (padding só se o projeto já usar) |
| `hostname` | Hostname curto |
| `resumo-curto` | 3–6 palavras kebab-case, sem acentos |

**Exceção:** Commit+Push exclusivo → não criar CCIA.

Conteúdo mínimo: título `# CCIA — …`, data/hora + hostname, pedido, feito/decisões, arquivos, validações, pendências, próximo passo. Sem segredos/PII.

## Handoff diário

```text
YYYY-MM-DD-handoff-<hostname>.md
```

Criar/atualizar quando o usuário pedir "handoff" / "fechar sessão".

## Quando **ler** CCIA/handoff

**Somente** sob pedido explícito do usuário — por exemplo: troca de PC/notebook e instrução para analisar `@prompts/...`.

O agente **não** deve ler handoffs automaticamente só porque o hostname mudou ou houve `git pull`.

Norma completa: `spec-project-bootstrap.md` §5.11.
