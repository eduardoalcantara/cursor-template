# prompts/

Prompts reutilizáveis (colas) e **CCIA** (Conversas com o Agente) para continuidade multi-máquina via Git.

Colas **não** substituem `flow.md` / `.cursorrules`. CCIA **não** substitui `status.md` / `timeline.md` / `.prompt-status`.

**Este repositório-fonte do template:** não gravar arquivos CCIA de conversa aqui (só colas + este `readme.md`). CCIA aplica-se aos **projetos derivados**.

## Colas oficiais do template

| Arquivo | Uso |
|---|---|
| `so-investigar.md` | Só investigar; não editar |
| `revisar-diff.md` | Revisar alterações / diff |
| `fechar-sessao-handoff.md` | Fechar sessão e gravar handoff diário |
| `validar-estrutura.md` | Rodar e interpretar `validate-structure` |

Specs opt-in (incl. personalizar projeto): `specs/optional/`.

## CCIA — transcrição literal por chat (projetos derivados)

Objetivo: em outra máquina, o Cursor (sob `@` explícito) recupera **o que foi conversado** sobre o mesmo repo — não um resumo de entrega.

- **1 arquivo por chat aberto** (criar no 1º turno relevante; **append** nos turnos seguintes do mesmo chat).
- Conteúdo = transcrição **literal** do prompt do usuário e da resposta final do agente.
- **Proibido** usar CCIA como resumo de “o que foi feito” — isso é papel de `timeline.md` / `status.md`.

```text
YYYY-MM-DD-<hostname>-<slug-chat>.md
```

| Parte | Regra |
|---|---|
| `YYYY-MM-DD` | Data local do início do chat |
| `hostname` | Hostname curto ASCII |
| `slug-chat` | 3–6 palavras kebab-case (tema do chat), sem acentos |

**Exceção:** Commit+Push exclusivo → não gravar/append CCIA.

### Formato de cada turno (append)

```markdown
## Turno N — YYYY-MM-DD HH:mm (hostname)

### Prompt
<texto literal do usuário>

### Resposta
<texto literal da resposta final do agente>
```

Sem segredos/PII (redigir tokens, senhas, webhooks, chaves). Não inventar nem condensar o diálogo.

## Handoff diário

```text
YYYY-MM-DD-handoff-<hostname>.md
```

Criar/atualizar quando o usuário pedir "handoff" / "fechar sessão". Handoff é **resumo de sessão** (estado, bloqueios, onde paramos, CCIAs do dia, próximo passo) — distinto da transcrição CCIA.

## Quando **ler** CCIA/handoff

**Somente** sob pedido explícito do usuário — por exemplo: troca de PC/notebook e instrução para analisar `@prompts/...`.

O agente **não** deve ler handoffs automaticamente só porque o hostname mudou ou houve `git pull`.

Norma completa: `spec-project-bootstrap.md` §5.11.
