# Spec opcional — Software multi-produto (DB, API, web, mobile)

> **Opt-in:** esta spec vive em `specs/optional/`. Só implemente depois de copiá-la para `specs/to-do/` e o operador confirmar que o repositório é desse tipo.

## Objetivo

Padronizar a estrutura e o rito de trabalho no Cursor para sistemas greenfield com vários produtos sob `/core`: banco de dados, API, frontend web e cliente(s) mobile, com contratos compartilhados e blast radius controlado.

## Dependências

- Relação com `spec-root.md`: especializa o domínio software em `/core` sem alterar a governança da raiz.
- Specs anteriores: nenhuma (pode ser a primeira spec de domínio).
- Pré-requisitos técnicos: repositório materializado a partir do template; pasta `/core` existente.
- Norma de origem: `spec-project-bootstrap.md` §8.1 (software) + esta spec quando ativada.

## Escopo

- Layout canônico de `/core` para multi-produto.
- Specs filhas sugeridas (DB, API, web, mobile, contrato de plataforma).
- Ordem de bootstrap greenfield.
- Regras de blast radius e tag de produto no prompt.
- Contrato de API como fonte da verdade para clientes.
- Seeds/personas compartilhados.
- Ambientes e `.env.example` por produto.
- Colas opcionais em `prompts/` (criar sob demanda).
- ADR leve em `docs/adr/` quando houver decisão de stack/monorepo.

## Fora de escopo

- Escolher stack concreta (Nest, FastAPI, React, Flutter, etc.) — fica no projeto filho / ADR.
- Microserviços obrigatórios no dia 1.
- Implementar features de negócio.
- Tornar esta spec obrigatória para todo repo gerado do template.
- Introduzir `.cursor/rules/` como dependência.

## Requisitos

1. Existir layout sob `/core` (criar pastas + `readme.md` mínimos conforme resultado esperado).
2. Documentar no `core/readme.md` o mapa de produtos e a regra de blast radius.
3. Criar (ou referenciar) spec de contrato de plataforma e specs por produto em `specs/to-do/` quando o operador autorizar a sequência.
4. Definir ordem de implementação: domínio/dados → migrations/seeds → API+contrato → web → mobile → CI/observabilidade.
5. Exigir que mudanças em `shared/` ou no contrato listem impacto nos consumidores.
6. Manter segredos fora do Git/CCIA; versionar só `.env.example`.
7. Não misturar produtos no mesmo prompt sem autorização explícita.

## Resultado esperado

```text
core/
  readme.md                 # mapa de produtos + blast radius
  shared/                   # contratos, tipos, libs compartilhadas
    readme.md
  db/                       # schema, migrations, seeds
    readme.md
  api/
    readme.md
  web/
    readme.md
  mobile/                   # ou mobile-ios / mobile-android se necessário
    readme.md
```

Opcional conforme necessidade do projeto: `core/workers/`.

Em `docs/adr/` (se ainda não existir): pasta com `readme.md` explicando que decisões de stack/auth/monorepo vivem ali.

## Critérios de aceite

- [ ] Layout `/core/{shared,db,api,web,mobile}` criado com `readme.md` em cada pasta
- [ ] `core/readme.md` descreve produtos, ordem de bootstrap e blast radius
- [ ] Esta spec foi promovida de `optional/` → `to-do/` antes da implementação
- [ ] Nenhuma stack concreta imposta sem ADR ou pedido explícito
- [ ] Documentação atualizada (`status.md`, `timeline.md`)
- [ ] CCIA gravado se a entrega for relevante (ler CCIA só sob pedido explícito)
- [ ] `.prompt-status` atualizado na entrada (2 campos; exceto Commit+Push)

## Impacto

- Usuários / operadores: onboarding previsível em sistemas multi-app
- Arquitetura: monorepo sob `/core` com fronteiras claras por produto
- Documentação: ADRs e specs por produto
- Cursor: menos misturar API/web/mobile no mesmo turno

## Arquivos afetados (típicos ao implementar)

- `core/readme.md`
- `core/shared/readme.md`, `core/db/readme.md`, `core/api/readme.md`, `core/web/readme.md`, `core/mobile/readme.md`
- `docs/adr/readme.md` (se criado)
- `status.md`, `timeline.md`
- Opcional: colas em `prompts/` (`gerar-migration.md`, `sincronizar-cliente-com-openapi.md`, etc.)

## Validações

- [ ] Pastas do layout existem
- [ ] `core/readme.md` cita esta spec e a regra “um produto por prompt”
- [ ] Nenhuma pasta de produto criada fora de `/core` sem justificativa normativa

## Riscos

- Criar demasiadas pastas vazias cedo demais → mitigar: só o layout + readmes; código quando houver spec ativa por produto.
- Agent implementar web antes da API → mitigar: ordem de bootstrap obrigatória salvo pedido explícito.
- Contrato divergir entre web e mobile → mitigar: OpenAPI (ou equivalente) em `shared/` ou `api/contracts/` como fonte da verdade.

## Sequência sugerida de specs filhas (após ativar esta)

1. `contrato-plataforma` — auth, IDs, erros, versionamento de API  
2. `db-schema-inicial` — migrations + seeds/personas  
3. `api-mvp` — endpoints do happy path + contrato publicado  
4. `web-mvp` — consome o contrato  
5. `mobile-mvp` — consome o mesmo contrato  
6. `ci-qualidade-por-produto` — lint/test/build por pasta  

## Regras operacionais para o Agent (quando esta spec estiver em `to-do/`)

- Prefixo mental de produto no escopo: `[db]` `[api]` `[web]` `[mobile]` `[shared]`.
- Proibido editar outro produto “de passagem”.
- Breaking change na API ⇒ registrar em `timeline.md` e abrir tarefas nos clientes.
- Leitura condicional e demais normas do template permanecem válidas.

## Próxima spec

- A definir pelo operador (começar por `contrato-plataforma` ou `db-schema-inicial`).
