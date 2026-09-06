# specs/

Especificações formais do projeto.

## Estrutura

- `to-do/` — specs **ativas** ou pendentes de implementação
- `done/` — specs concluídas
- `optional/` — catálogo **opt-in** do template (não é escopo ativo)

## Regras

- Use `spec-template.md` da raiz como molde.
- Relacione cada spec explicitamente com `spec-root.md`.
- Critérios de aceite devem ser verificáveis.
- Ao concluir, mova o arquivo de `to-do/` para `done/`.
- Specs em `optional/` **só** entram em escopo depois de copiadas/movidas para `to-do/` com confirmação do operador (ex.: projeto multi-produto → `software-multi-produto.md`).
- O Agent **não** implementa `optional/` por iniciativa própria.
