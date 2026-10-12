# core/

Núcleo **essencial** do produto/sistema — o que permite continuar a manutenção se o resto do repositório sumir.

## Critério de decisão (obrigatório)

Pergunte:

1. **Cópia mínima:** se um dia for preciso copiar só o essencial para continuar alterando código, compilando, rodando e gerando instalador — o que deve bastar? Resposta: **apenas `/core`**. Isso inclui scripts **essenciais** a esses propósitos (build, run, empacote, instalador do produto). Scripts só do repositório (validar estrutura do template, bootstrap de docs, etc.) ficam em `scripts/` na raiz.
2. **Incêndio:** o que você colocaria debaixo do braço e salvaria se não desse tempo de salvar tudo? Isso vive em `/core`.

Se o artefato não for necessário para manter/compilar/rodar/instalar o produto em produção (ou equivalente no domínio), **não** pertence a `/core`.

## O que entra

Código, contratos, schemas, migrations do produto, assets necessários ao build/run, firmware, CAD, perfis de SO, modelos 3D, e **scripts essenciais do produto** (sempre que o padrão da tecnologia não exigir outro local).

## O que não entra

Governança do repositório (raiz: `spec-*`, `rules*`, `flow.md`, `.cursorrules`), CCIA/colas em `prompts/`, docs de apoio, `reports/`, `resources/` de downloads, e scripts **não essenciais ao produto** em `scripts/` (validação estrutural do repo, automação de template, manutenção documental).

## Exemplos por domínio

| Domínio | Subpastas possíveis |
|---|---|
| Software (app único) | `src/`, `tests/`, `api/`, `packages/`, scripts de build/run/installer |
| Software multi-produto | ver spec opt-in `specs/optional/software-multi-produto.md` → `shared/`, `db/`, `api/`, `web/`, `mobile/` |
| Hardware | `cad/`, `bom/`, `schematics/`, `firmware/` |
| Sistema operacional | `profiles/`, `policies/`, `services/` |
| Impressão 3D | `models/`, `slicing/`, `materials/` |
| Híbrido | combinação das acima |

## Regra

A governança do repositório fica na raiz; o **produto** (incl. o mínimo operacional) fica em `/core`.

Para sistemas com DB + API + web + mobile: **não** inventar o layout — promover a spec opcional para `specs/to-do/` e seguir o aceite dela.
