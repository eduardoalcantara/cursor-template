# rules.md — regras permanentes de governança

## Hierarquia normativa

1. `spec-root.md` — autoridade arquitetural máxima
2. `rules.md` — este arquivo (governança permanente)
3. `.cursorrules` — comportamento do agente (canônico neste template)
4. `flow.md` — sequência operacional
5. `rules-scripts.md` — governança de scripts
6. Specs em `specs/` — entregas formais
7. Docs, ideas e references — apoio (não normativo por padrão)

Em conflito: nível superior prevalece. Se irresolvido → pause e peça esclarecimento.

**Nota:** este template **não** depende de `.cursor/rules/` como fonte normativa. A norma vive em `.cursorrules` + este arquivo + bootstrap.

## Regras gerais permanentes

- Não inventar requisitos. Não extrapolar escopo.
- Ser honesto sobre limites, dúvidas e validações.
- Manter a raiz documental viva e coerente.
- Conteúdo específico do projeto vive em `/core` sempre que aplicável.
- Preferir mudanças pequenas; não reescrever o que o pedido não pediu.

## Regras de escopo

- Implementar somente o confirmado em `spec-root.md` ou em specs ativas em `specs/to-do/`.
- Spec ativa tem prioridade; não abrir escopo paralelo sem autorização.
- Não misturar grupos/temas sem autorização.

## Regras de qualidade e performance no Cursor

- Leitura **condicional** (ver `flow.md` / `.cursorrules`).
- Orçamento de contexto: `@arquivo` pontual; evitar pastas grandes e CCIAs antigos.
- Um prompt = um modo de tarefa.
- Limite de exploração: pause com opções se não houver progresso.
- `.cursorignore` deve excluir binários, downloads, logs e segredos da indexação.

## Regras de documentação

- Mudanças relevantes atualizam `status.md` e `timeline.md`.
- Entregas materiais geram relatório em `reports/`.
- Specs novas usam `spec-template.md`; concluídas vão para `specs/done/`.

## Regras de validação

- Validar o possível; não afirmar sucesso sem evidência; registrar o não validado.

## Regras de bloqueio

Pause quando: faltar contexto; houver contradição; escopo indefinido; ação destrutiva sem confirmação.

## Regras de atualização e rastreio

- Alterar `spec-root.md` só com intenção explícita de mudar a arquitetura.
- `.prompt-status` mínimo (só `current_prompt_number` e `current_prompt_start_time`); update **só na entrada**; exceção Commit+Push.
- CCIA: **gravar** após prompt relevante; **ler** só se o usuário pedir explicitamente.
- Em Commit+Push exclusivo: não alterar `.prompt-status` nem criar CCIA.

## Regras de scripts (resumo)

Detalhes em `rules-scripts.md`:

- instalação com `--uninstall` reversível;
- cabeçalho operacional tabelado em ciano;
- menus numerados: `0` = não, `1` = sim, Enter = default;
- modos `--quiet`, `--ssh`, `--force`, `--log` quando aplicável.
