# core/

Núcleo específico do projeto.

Tudo que for próprio do domínio (código, modelos, schemas, componentes, ativos, firmware, CAD, etc.) deve viver aqui — sempre que isso não contrariar o padrão da tecnologia.

## Exemplos por domínio

| Domínio | Subpastas possíveis |
|---|---|
| Software (app único) | `src/`, `tests/`, `api/`, `packages/` |
| Software multi-produto | ver spec opt-in `specs/optional/software-multi-produto.md` → `shared/`, `db/`, `api/`, `web/`, `mobile/` |
| Hardware | `cad/`, `bom/`, `schematics/`, `firmware/` |
| Sistema operacional | `profiles/`, `policies/`, `services/` |
| Impressão 3D | `models/`, `slicing/`, `materials/` |
| Híbrido | combinação das acima |

## Regra

A governança do repositório fica na raiz; o produto/domínio fica em `/core`.

Para sistemas com DB + API + web + mobile: **não** inventar o layout — promover a spec opcional para `specs/to-do/` e seguir o aceite dela.
