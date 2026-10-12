# timeline.md — histórico evolutivo (cronológico reverso)

## 2026-10-12 — Critérios explícitos de `/core`

- **Evento:** documentação de `/core` como essencial do produto (cópia mínima para manter/compilar/rodar/instalar; critério do “incêndio”), com fronteira vs `scripts/` da raiz.
- **Impacto:** reduz ambiguidade do agente em repos de sistemas sobre o que deve ir em `/core`.
- **Arquivos afetados:** `core/readme.md`, `scripts/readme.md`, `readme.md`, `spec-root.md`, `spec-project-bootstrap.md`, `status.md`, `timeline.md`.
- **Observações:** scripts essenciais do produto ficam em `/core`; scripts só do repositório ficam em `scripts/`.

## 2026-07-26 — Padronização de nomes com hífen

- **Evento:** renomeação de `spec_root.md`, `spec_template.md` e `rules_scripts.md` para hífen.
- **Impacto:** nomenclatura consistente em toda a documentação e scripts de validação.
- **Arquivos afetados:** `spec-root.md`, `spec-template.md`, `rules-scripts.md` e referências em docs/scripts.
- **Observações:** validação estrutural reexecutada com sucesso.

## 2026-07-26 — Implementação do template universal

- **Evento:** materialização da estrutura definida em `spec-project-bootstrap.md`.
- **Impacto:** o repositório passa a funcionar como fundação pronta para novos projetos Cursor via GitHub template.
- **Arquivos afetados:** raiz documental (`.gitignore`, `readme.md`, `spec-root.md`, `flow.md`, `rules.md`, `status.md`, `timeline.md`, `setup.md`, `tools-linux.md`, `tools-windows.md`, `.cursorrules`, `.prompt-status`, `spec-template.md`, `rules-scripts.md`), pastas operacionais e scripts de validação.
- **Observações:** placeholders `[NOME DO PROJETO]` devem ser preenchidos em cada projeto derivado.

## 2026-07-26 — Criação do documento de fundação

- **Evento:** criação de `spec-project-bootstrap.md`.
- **Impacto:** definição normativa da espinha dorsal de qualquer novo repositório no Cursor.
- **Arquivos afetados:** `spec-project-bootstrap.md`.
- **Observações:** commit inicial de especificação; implementação estrutural veio em seguida.
