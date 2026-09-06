# specs/optional/

Catálogo de **specs opt-in**: prontas no template, mas **não** entram em `to-do/` automaticamente.

## Quando usar

1. O operador confirma que o repositório é do tipo da spec (ex.: sistema multi-produto).
2. Copia (ou move) a spec para `specs/to-do/`.
3. O Agent implementa **somente** o que estiver em `to-do/` (e o escopo da spec ativa).

## Regras

- Specs aqui **não** são escopo ativo.
- Não implementar conteúdo de `optional/` “por precaução”.
- Ao concluir uma spec promovida, mova para `specs/done/` como qualquer outra.
- Use `spec-template.md` como molde para novas specs opcionais.

## Catálogo

| Spec | Tipo / uso |
|---|---|
| `bootstrap-personalizar-projeto.md` | Após criar repo a partir do template (personalizar placeholders) |
| `software-multi-produto.md` | Sistema com DB + API + web + mobile (e shared) |
