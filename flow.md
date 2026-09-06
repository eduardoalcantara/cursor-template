# flow.md — fluxo operacional do agente

## Leitura condicional

Não ler a raiz inteira em todo prompt.

| Situação | Ler |
|---|---|
| Sempre | `.cursorrules`, `.prompt-status` (exceto Commit+Push exclusivo) |
| Usuário pediu atualizar via CCIA/handoff | O(s) arquivo(s) `@` indicados em `prompts/` |
| Implementar / documentar | `spec-root.md`, `rules.md`, e trechos necessários de `flow.md` |
| Scripts | `rules-scripts.md` |
| Entrega material | `status.md`, `timeline.md` |
| Spec ativa em `specs/to-do/` | A spec ativa (escopo mandatório) |

## Modos de tarefa

Um prompt → um modo: `explorar` | `implementar` | `corrigir` | `documentar` | `commit+push`.

## Fluxo de execução

1. Identificar modo e escopo.
2. Ler só o necessário (tabela acima).
3. Atualizar `.prompt-status` na entrada (2 campos; ver abaixo) — exceto Commit+Push exclusivo.
4. Executar só o escopo confirmado (sem refactor espontâneo).
5. Validar ou declarar limitação.
6. Atualizar `status.md` / `timeline.md` se material.
7. Gravar CCIA se prompt relevante (não criar em Commit+Push exclusivo).
8. Responder com dados mínimos + DoD + rodapé.

## `.prompt-status` (mínimo)

```text
current_prompt_number = N
current_prompt_start_time = ISO-8601
```

| Momento | Ação |
|---|---|
| Entrada | duração_anterior = agora − start; number++; start = agora |
| Saída | **não** alterar |
| Commit+Push exclusivo | **não** alterar |

Rodapé: `> Resposta do Cursor nº {Nn}, usando {LLMs}, com duração de {mm:nn}.`  
Duração do turno = agora − `current_prompt_start_time`.

## CCIA / handoff

- **Gravar** após entrega relevante; handoff diário se pedido.
- **Ler** somente sob pedido explícito do usuário (troca de máquina + `@arquivo`).
- Detalhes: `prompts/readme.md` e `spec-project-bootstrap.md` §5.11.

## Checklist (DoD)

- [ ] Modo e escopo claros
- [ ] Leitura condicional feita
- [ ] `.prompt-status` atualizado na entrada (se aplicável)
- [ ] Sem refactor fora do pedido
- [ ] Validação ou limitação declarada
- [ ] Docs atualizados se material
- [ ] CCIA gravado se relevante
- [ ] Próximo passo explícito

## Limite de exploração

Sem progresso após ~8 buscas/leituras → pause com opções numeradas.
