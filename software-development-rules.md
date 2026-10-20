# software-development-rules.md — engenharia de software no `/core`

## Quando aplicar (condicional)

**Seguir este arquivo** quando o repositório (ou a entrega em curso) for de **desenvolvimento de software/sistemas**: código de produto em `/core`, APIs, apps, serviços, bibliotecas, clientes, etc.

**Ignorar este arquivo** quando o domínio **não** for software de produto — por exemplo: só documentação/template, hardware/CAD sem firmware, impressão 3D, configuração de SO sem código de aplicação, ou pedido explícito fora desse escopo.

Em dúvida material: PAUSE e pergunte. Não aplicar padrões “por precaução” em repos que não são de software.

Referência canônica de padrões: [Catálogo de Design Patterns — Refactoring.Guru](https://refactoring.guru/design-patterns/catalog).

## Princípios permanentes

1. **Simplicidade primeiro** — KISS / YAGNI: resolva o problema confirmado; não antecipe frameworks nem camadas sem necessidade.
2. **SOLID** (orientação a objetos / modularidade):
   - **S** — uma responsabilidade clara por módulo/classe/função exportada.
   - **O** — estender por composição/estratégia em vez de reescrever núcleos estáveis.
   - **L** — subtítulos/implementações substituíveis sem quebrar contratos.
   - **I** — interfaces pequenas e coesas; evitar “god interfaces”.
   - **D** — depender de abstrações estáveis; detalhes (IO, DB, HTTP, FS) nas bordas.
3. **Injeção de dependências (DI)** — colaborações injetadas (construtor/fábrica/container da stack); evitar `new` de infra no meio da regra de negócio; facilitar teste e troca de implementação.
4. **Separação de interesses** — domínio ≠ persistência ≠ apresentação ≠ I/O; efeitos colaterais nas bordas.
5. **Contratos explícitos** — tipos/interfaces/schemas claros nas fronteiras (`/core/shared`, OpenAPI, etc. quando o projeto usar).
6. **Testabilidade** — código novo/alterado deve ser testável; preferir testes no nível que reduz risco (unitário nas regras, integração nas bordas).
7. **Sem over-engineering** — padrão só quando remove duplicação real, isola variação real ou desacopla borda real. Padrão sem dor = complexidade gratuita.

## Design Patterns (catálogo de referência)

Antes de introduzir um padrão, consulte o catálogo e escolha o que realmente se aplica:

| Família | Padrões (referência) |
|---|---|
| Criacionais | Factory Method, Abstract Factory, Builder, Prototype, Singleton |
| Estruturais | Adapter, Bridge, Composite, Decorator, Facade, Flyweight, Proxy |
| Comportamentais | Chain of Responsibility, Command, Iterator, Mediator, Memento, Observer, State, Strategy, Template Method, Visitor |

Fonte: [https://refactoring.guru/design-patterns/catalog](https://refactoring.guru/design-patterns/catalog)

### Regras de uso de padrões

- Nomeie o padrão na decisão (código/ADR/spec) quando for não óbvio.
- Prefira **Strategy**, **Adapter**, **Facade**, **Factory Method** e **Builder** quando houver variação/borda clara.
- Use **Singleton** só com justificativa forte (estado global compartilhado inevitável); DI costuma ser melhor.
- Não empilhar padrões “de livro” em CRUD simples.
- Em conflito entre elegância do padrão e clareza do time/stack: prevalece clareza + teste.

## Práticas operacionais no código

- Funções/métodos curtos; nomes revelam intenção; evite parâmetros longos (introduza objeto/DTO quando fizer sentido).
- Trate erros de forma explícita na stack do projeto; não engula exceções.
- Evite duplicação acidental (DRY com julgamento — abstrair cedo demais também é dívida).
- Segredos fora do código; config por ambiente.
- Respeite o layout de `/core` do projeto (ex.: multi-produto em `specs/optional/software-multi-produto.md`).
- Scripts essenciais de build/run/pack/install do produto ficam em `/core` (ver `core/readme.md`).

## Relação com a governança do template

| Documento | Papel |
|---|---|
| `spec-root.md` / `rules.md` | Autoridade e governança do repositório |
| `.cursorrules` / `flow.md` | Quando ler este arquivo |
| `rules-scripts.md` | Scripts do **repo** e UX de scripts |
| Este arquivo | Qualidade e desenho do **código de software** em `/core` |

Conflito com `spec-root.md` / `rules.md`: prevalece a hierarquia de `rules.md`. Este arquivo não autoriza refactor amplo espontâneo — continua valendo o modo e o escopo do prompt.
