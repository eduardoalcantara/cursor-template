# Spec opcional — Personalizar projeto a partir do template

> **Opt-in / cola:** vive em `specs/optional/`. Use após criar um repositório a partir do template (cole no chat ou promova o fluxo). Não é escopo contínuo de domínio.

## Objetivo

Personalizar placeholders e estado inicial do repositório recém-criado a partir do template, sem implementar o domínio ainda.

## Como usar

Modo: `documentar` / setup inicial.

Leitura condicional: `.cursorrules`, `.prompt-status`, `spec-root.md`, `rules.md`, `status.md`, `setup.md` (e `flow.md` se precisar).

Objetivo: personalizar este repositório para o projeto **[NOME DO PROJETO]**.

Faça somente o seguinte:
1. Substituir placeholders óbvios (`[NOME DO PROJETO]`, propósito, público) em `readme.md` e `spec-root.md`.
2. Atualizar `status.md` com o estado inicial do projeto real.
3. Adicionar uma entrada em `timeline.md` registrando a criação do projeto a partir do template.
4. Criar a primeira spec em `specs/to-do/` usando `spec-template.md`, com escopo **[DESCREVER]**.
5. Atualizar `.prompt-status` na entrada (só `current_prompt_number` e `current_prompt_start_time`; exceção Commit+Push).

Não implemente o domínio ainda. Não altere a estrutura de pastas sem necessidade. Coloque conteúdo específico futuro em `/core`. Não leia CCIA/handoff a menos que eu peça.

## Critérios de aceite

- [ ] Placeholders principais revisados
- [ ] `status.md` e `timeline.md` atualizados
- [ ] Primeira spec em `specs/to-do/` (se o operador definiu escopo)
- [ ] Nenhuma implementação de domínio fora do pedido
