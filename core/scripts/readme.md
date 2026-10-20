# core/scripts/

Scripts **essenciais do produto** — build, run, empacote, instalador e manutenção operacional do que vive em `/core`.

## Por que aqui (não em `scripts/` na raiz)

Critérios de `/core` (ver `core/readme.md`):

1. **Cópia mínima** — copiar só `/core` deve bastar para alterar, compilar, rodar e gerar instalador.
2. **Incêndio** — o que se salvaria se não desse tempo de salvar o resto do repo.

Scripts que servem só ao **repositório** (validar estrutura do template, bootstrap documental, etc.) ficam em `scripts/` na raiz.

## O que colocar aqui

| Tipo | Exemplos (adaptar à stack do projeto) |
|---|---|
| Build / run | compilar, testes do produto, subir o app/serviço |
| Release / pack | gerar artefato de distribuição |
| Instalador | MSI, deb, rpm, imagem, pacote da plataforma |
| Manutenção do produto | associação de extensão, serviço, migração operacional |

Subpastas opcionais (quando fizer sentido): `automation/`, `maintenance/`, `bootstrap/` — sempre com foco no **produto**, não na governança do template.

## O que não colocar aqui

- Validação da árvore do template (`validate-structure`, etc.)
- Automação de docs, CCIA, specs
- Qualquer script dispensável se só `/core` for copiado

## Convenções

- Seguir `rules-scripts.md` na raiz (input numerado, `--uninstall` quando instalar algo, equivalência `.sh` / `.ps1` quando houver ambos).
- Descobrir a raiz do **produto** a partir de marcadores do domínio em `/core` (ex.: `package.json`, `Cargo.toml`, `pyproject.toml`, `.sln`) — **não** depender de `spec-root.md` da governança.
- Documentar nesta tabela os scripts reais do projeto derivado:

| Script | Função |
|---|---|
| _(preencher ao criar o produto)_ | |

## Wrappers na raiz (opcional)

No repositório completo, pode existir atalho em `scripts/` da raiz que apenas encaminha para `core/scripts/…`. O canônico continua sendo este diretório.
