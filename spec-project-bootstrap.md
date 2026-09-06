# spec-project-bootstrap.md

## Objetivo

Este documento define a fundação universal para criação de qualquer novo repositório no Cursor.

Ele serve para projetos de software, hardware, configuração de sistema operacional, automação, impressão 3D, documentação técnica, pesquisa, ferramentas, bibliotecas, protótipos ou qualquer combinação desses domínios.

A meta é padronizar a raiz do repositório com estrutura, governança, contexto operacional e orientação suficiente para que o Cursor consiga trabalhar com consistência desde o primeiro momento.

### Contrato de reprodução (obrigatório)

Este arquivo (`spec-project-bootstrap.md`) é a **receita normativa** do repositório template. Se o Cursor **ler e implementar** este documento em uma **pasta vazia**, o resultado deve ser um repositório **equivalente** a este template: mesmos arquivos de governança da raiz, mesmas pastas operacionais (com `readme.md` onde aplicável), mesmas regras de `.prompt-status` e CCIA, scripts de validação e cola de bootstrap em `prompts/`.

Novos repositórios gerados a partir do template (GitHub Template ou materialização via Cursor) herdam essa estrutura; o domínio específico do projeto vive em `/core` e nos placeholders.

---

## 1. Princípios centrais

### 1.1 Repositório nasce documentado
Todo projeto deve começar com uma estrutura mínima de contexto, não com arquivos soltos sem governança.

### 1.2 A raiz é a fonte de orientação
Os arquivos da raiz não são enfeites; cada um tem função operacional específica.

### 1.3 O agente precisa de contexto explícito
O Cursor deve encontrar no repositório as regras, o fluxo, o estado, o histórico e a orientação de trabalho.

### 1.4 O formato é universal, o conteúdo é adaptável
A espinha dorsal se mantém; o interior das pastas muda conforme o domínio do projeto.

### 1.5 Existe uma pasta `/core`
Todo projeto deve conter uma pasta `/core`, que concentra as pastas, arquivos e artefatos específicos do projeto.

### Regra obrigatória
Tudo que for específico do projeto deve viver sob `/core` sempre que isso não contrariar o padrão da tecnologia ou do domínio.

### 1.6 Existe um arquivo `.prompt-status`
Todo projeto deve conter um arquivo `.prompt-status` na raiz com **apenas** duas chaves: `current_prompt_number` e `current_prompt_start_time` (ver §5.10 e §11).

### 1.7 Rastreamento de execução é obrigatório
Antes de executar um prompt, o Cursor AI deve ler `.prompt-status`.

**Regra de atualização (entrada apenas):** o agente atualiza `.prompt-status` **somente no início da resposta**, **nunca na saída**. Na entrada: calcular duração do prompt anterior (`agora − current_prompt_start_time`), incrementar `current_prompt_number` e gravar novo `current_prompt_start_time`.

**Exceção — Commit + Push:** quando o pedido for **exclusivamente** versionamento Git (`commit`, `push`, `commit + push` ou equivalente), **não** atualizar `.prompt-status` (nem na entrada).

### 1.8 Continuidade multi-máquina via CCIA
O histórico de chat do Cursor **não** viaja com o Git. Todo repositório materializado deve nascer com `prompts/` preparado para **CCIA** (gravação após prompts relevantes; handoff diário sob pedido). A **leitura** de CCIA/handoff ocorre **somente** quando o usuário pedir explicitamente (ex.: troca de PC + `@arquivo`) — ver §5.11.

### 1.9 Performance de trabalho no Cursor
Leitura condicional, orçamento de `@`, um modo por prompt, anti-refactor espontâneo, limite de exploração, `.cursorignore` e DoD — ver §5.4 e §5.12. A norma canônica do agente neste template é `.cursorrules` na raiz (não depender de `.cursor/rules/`).

---

## 2. Estrutura raiz padrão

Todo novo repositório deve possuir, sempre que aplicável, os seguintes itens na raiz:

- `.gitignore`
- `.cursorignore`
- `readme.md`
- `spec-project-bootstrap.md` — esta receita (viaja com o template)
- `spec-root.md`
- `flow.md`
- `rules.md`
- `status.md`
- `timeline.md`
- `setup.md`
- `tools-linux.md`
- `tools-windows.md`
- `.cursorrules`
- `.prompt-status`
- `spec-template.md`
- `rules-scripts.md`
- `docs/`
- `ideas/`
- `specs/` (`to-do/`, `done/`, `optional/` — catálogo opt-in)
- `references/`
- `scripts/` (`bootstrap/`, `validation/`, `automation/`, `maintenance/`)
- `reports/`
- `prompts/` (colas + CCIA; obrigatório `readme.md`)
- `resources/` (`downloads/`)
- `core/`

### Regra
Pastas opcionais podem não existir em todos os projetos, mas a intenção estrutural deve permanecer clara. Para **reproduzir o template**, a árvore canônica da §2.1 é obrigatória.

### Convenção de nomenclatura (arquivos na raiz)
- Arquivos Markdown de governança na raiz usam **hífen** (`-`) como separador de palavras, **nunca** underscore (`_`).
- Exemplos corretos: `spec-root.md`, `spec-template.md`, `rules-scripts.md`, `tools-linux.md`, `tools-windows.md`, `spec-project-bootstrap.md`.
- Ao criar um repositório a partir deste template, o Cursor deve **preservar exatamente** esses nomes com hífen.

### 2.1 Árvore canônica (materialização em pasta vazia)

O Cursor, ao implementar este documento do zero, deve criar **no mínimo**:

```text
.gitignore
.cursorignore
readme.md
spec-project-bootstrap.md
spec-root.md
flow.md
rules.md
status.md
timeline.md
setup.md
tools-linux.md
tools-windows.md
.cursorrules
.prompt-status
spec-template.md
rules-scripts.md
docs/readme.md
ideas/readme.md
specs/readme.md
specs/to-do/readme.md
specs/done/readme.md
references/readme.md
scripts/readme.md
scripts/bootstrap/readme.md
scripts/validation/readme.md
scripts/validation/validate-structure.sh
scripts/validation/validate-structure.ps1
scripts/automation/readme.md
scripts/maintenance/readme.md
reports/readme.md
prompts/readme.md
prompts/so-investigar.md
prompts/revisar-diff.md
prompts/fechar-sessao-handoff.md
prompts/validar-estrutura.md
specs/optional/readme.md
specs/optional/bootstrap-personalizar-projeto.md
specs/optional/software-multi-produto.md
resources/readme.md
resources/downloads/.gitkeep
core/readme.md
```

Depois de criado, `scripts/validation/validate-structure.sh` (ou `.ps1`) deve passar com zero faltas.

---

## 3. Função dos arquivos da raiz

### 3.1 `.gitignore`
Define o que não deve entrar no versionamento.

### 3.1b `.cursorignore`
Define o que o Cursor não deve indexar (binários, downloads, logs, segredos, caches) — melhora busca e desempenho do Agent.

### 3.2 `readme.md`
Explica o projeto para humanos: propósito, visão, escopo e uso inicial.

### 3.2b `spec-project-bootstrap.md`
É a receita normativa para materializar o template (este arquivo). Deve viajar com o repositório template e permitir reprodução em pasta vazia.

### 3.3 `spec-root.md`
É a autoridade arquitetural máxima do repositório.

### 3.4 `flow.md`
Define o fluxo operacional do agente: o que ler, em que ordem agir e como validar.

### 3.5 `rules.md`
Centraliza regras permanentes de governança, escopo, arquitetura e qualidade.

### 3.6 `status.md`
Registra o estado atual do projeto como snapshot mutável.

### 3.7 `timeline.md`
Registra o histórico do projeto em ordem cronológica decrescente, como log evolutivo.

### 3.8 `setup.md`
Documenta preparação do ambiente, instalação, bootstrap e caminhos de suporte.

### 3.9 `tools-linux.md`
Lista ferramentas, pacotes e comandos relevantes para Linux.

### 3.10 `tools-windows.md`
Lista ferramentas, pacotes e comandos relevantes para Windows.

### 3.11 `.cursorrules`
Define comportamento, honestidade, limites e formato de resposta do agente no repositório.

### 3.12 `.prompt-status`
Arquivo mínimo com `current_prompt_number` e `current_prompt_start_time`. Atualização **apenas na entrada** (ver §5.10 e §11).

### 3.13 `spec-template.md`
Fornece o molde para novas specs do projeto.

### 3.14 `rules-scripts.md`
Define a governança de criação e execução de scripts, incluindo organização, input, cabeçalho, autodetecção da raiz, UX operacional e desinstalação reversa.

### 3.15 `docs/`
Armazena documentação técnica, operacional, normativa e de produto.

### 3.16 `ideas/`
Armazena hipóteses, rascunhos, propostas e ideias ainda não formalizadas.

### 3.17 `specs/`
Armazena especificações formais do projeto, com subpastas `to-do/` e `done/` (escopo ativo/concluído) e `optional/` (catálogo opt-in do template: só implementar após promoção a `to-do/`).

### 3.18 `references/`
Armazena referências locais, engenharia reversa, exemplos e materiais de estudo.

### 3.19 `scripts/`
Armazena scripts de automação, bootstrap, validação e apoio operacional, organizados em `bootstrap/`, `validation/`, `automation/` e `maintenance/`. Em `validation/` devem existir `validate-structure.sh` e `validate-structure.ps1`.

### 3.20 `reports/`
Armazena relatórios de implementação, auditoria, validação e entrega.

### 3.21 `prompts/`
Armazena colas oficiais e CCIA. Obrigatório na materialização: `readme.md`, `so-investigar.md`, `revisar-diff.md`, `fechar-sessao-handoff.md`, `validar-estrutura.md`. Personalização inicial do repo: spec opt-in `specs/optional/bootstrap-personalizar-projeto.md`. **Gravar** CCIA após prompts relevantes; **ler** só sob pedido explícito do usuário.

### 3.22 `resources/`
Armazena downloads, binários, imagens, apps auxiliares e materiais de apoio; inclui `downloads/` (com `.gitkeep` se vazia).

### 3.23 `core/`
Armazena o conteúdo específico do projeto, incluindo pastas de domínio, arquivos-fonte, ativos, modelos, componentes e artefatos operacionais próprios do repositório. Deve nascer com `core/readme.md`.

---

## 4. Estrutura correta de cada arquivo

### 4.1 `.gitignore`
- Ignorar artefatos temporários.
- Ignorar saídas de build, caches, logs e arquivos locais.
- Ignorar segredos, credenciais e arquivos específicos do ambiente.
- Não ignorar arquivos de governança do projeto.

### 4.1b `.cursorignore`
- Excluir da indexação do Cursor: `resources/downloads/`, binários, logs, caches, `.env*` e dumps.
- Alinhar com `.gitignore` onde fizer sentido; pode ser mais agressivo que o Git.

### 4.2 `readme.md`
- Nome do projeto.
- Resumo do que ele faz.
- Público e objetivo.
- Estrutura de alto nível.
- Como iniciar.
- Documentação relacionada.
- Estado atual.

### 4.3 `spec-root.md`
- Propósito do projeto.
- Visão geral.
- Princípios fundacionais.
- Escopo.
- Fora de escopo.
- Arquitetura de alto nível.
- Contratos centrais.
- Regras permanentes.
- Critérios de sucesso.
- Conclusão normativa.

### 4.4 `flow.md`
- Leitura **condicional** (não obrigar a raiz inteira em todo prompt).
- Modos de tarefa (um por prompt).
- Fluxo de execução do agente.
- Checklist / DoD.
- Limite de exploração.
- `.prompt-status` mínimo (entrada apenas).
- CCIA: gravar após relevante; ler só sob pedido explícito.

### 4.5 `rules.md`
- Hierarquia normativa.
- Regras gerais permanentes.
- Regras de escopo (spec ativa manda).
- Regras de qualidade e performance no Cursor.
- Regras de documentação, validação, bloqueio e atualização.
- Nota: norma do agente em `.cursorrules` (não depender de `.cursor/rules/`).

### 4.6 `status.md`
- Data da última atualização.
- Resumo do estado atual.
- Tarefas concluídas.
- Tarefas pendentes.
- Riscos.
- Próximos passos.
- Mudanças recentes.

### 4.7 `timeline.md`
- Histórico cronológico reverso.
- Entrada por evento/entrega.
- Impacto.
- Arquivos afetados.
- Data.
- Observações relevantes.

### 4.8 `setup.md`
- Pré-requisitos.
- Instalação.
- Bootstrap.
- Variáveis de ambiente.
- Verificações.
- Execução inicial.
- Solução de problemas.

### 4.9 `tools-linux.md`
- Ferramentas necessárias.
- Comandos úteis.
- Dependências do sistema.
- Uso recomendado.
- Observações específicas de Linux.

### 4.10 `tools-windows.md`
- Ferramentas necessárias.
- Comandos úteis.
- Dependências do sistema.
- Uso recomendado.
- Observações específicas de Windows.

### 4.11 `.cursorrules`
- Perfil do agente e honestidade.
- Modo de tarefa (1 prompt = 1 modo).
- Leitura condicional e orçamento de contexto.
- Limite de exploração e anti-refactor espontâneo.
- `.prompt-status` mínimo (2 campos; entrada apenas; exceção Commit + Push).
- CCIA: gravar; ler só sob pedido explícito.
- DoD e dados mínimos de resposta.
- Scripts e input.
- Norma canônica do agente neste template (preferir `.cursorrules` na raiz a `.cursor/rules/` fragmentado).

### 4.12 `.prompt-status`
- Apenas `current_prompt_number` e `current_prompt_start_time`.
- Sem seções `[current]`/`[last]`/`[totals]`, sem LLM/status/resumo no arquivo.

### 4.13 `spec-template.md`
- Título.
- Objetivo.
- Dependências.
- Escopo.
- Fora de escopo.
- Requisitos.
- Resultado esperado.
- Critérios de aceite.
- Impacto.
- Arquivos afetados.
- Validações.
- Riscos.
- Próxima spec.
- Se aplicável, impacto sobre os fluxos de rastreio do Cursor AI.

### 4.14 `rules-scripts.md`
- Propósito.
- Escopo.
- Limpeza inicial da tela.
- Cabeçalho operacional.
- Organização por categoria macro.
- Descoberta da raiz do repositório.
- Parâmetros mínimos e input interativo.
- Uso de caminhos internos.
- Mensagens e UX operacional.
- Equivalência comportamental entre Linux e Windows.
- Scripts de instalação e desinstalação.
- Atualização documental.
- Regra final.

### 4.15 `docs/`
- Documentação técnica.
- Guias de uso.
- Decisões arquiteturais.
- Referências de implementação.
- Mudanças normativas.

### 4.16 `ideas/`
- Ideias soltas.
- Hipóteses.
- Propostas.
- Rascunhos.
- Explorações ainda não aprovadas.

### 4.17 `specs/`
- Specs formais.
- Subpastas `to-do/` e `done/` com `readme.md`.
- Subpasta `optional/` com catálogo opt-in (`readme.md` + specs como `bootstrap-personalizar-projeto.md`, `software-multi-produto.md`).
- Cada spec com escopo e critério de aceite.
- Relacionamento explícito com `spec-root.md`.
- Ordem por domínio ou grupo.
- Agent não implementa `optional/` por iniciativa própria.

### 4.18 `references/`
- Links, estudos, comparativos.
- Material de engenharia reversa.
- Arquivos de apoio e análise.
- Conteúdo consultivo, não normativo.
- `readme.md` na pasta.

### 4.19 `scripts/`
- `readme.md` na raiz de `scripts/` e em cada categoria.
- Categorias: `bootstrap/`, `validation/`, `automation/`, `maintenance/`.
- Em `validation/`: `validate-structure.sh` e `validate-structure.ps1` (estrutura mínima do template; marcadores de raiz: `spec-root.md` + `.prompt-status`).
- Equivalência comportamental Linux/Windows conforme `rules-scripts.md`.

### 4.20 `reports/`
- Relatórios de implementação.
- Relatórios de validação.
- Relatórios de auditoria.
- Relatórios de entrega.
- Evidências e impacto.
- `readme.md` na pasta.

### 4.21 `prompts/`
- `readme.md` (CCIA + colas; leitura de handoff só sob pedido explícito).
- Colas: `so-investigar.md`, `revisar-diff.md`, `fechar-sessao-handoff.md`, `validar-estrutura.md`.
- CCIA: `YYYY-MM-DD-NN-<hostname>-<resumo-curto>.md`.
- Handoff diário: `YYYY-MM-DD-handoff-<hostname>.md`.
- Personalizar projeto após criar o repo: `specs/optional/bootstrap-personalizar-projeto.md` (opt-in).

### 4.22 `resources/`
- Downloads.
- Binários.
- Imagens.
- Apps auxiliares.
- Materiais de apoio.
- `readme.md` e `downloads/.gitkeep` (se a pasta estiver vazia).

### 4.23 `core/`
- Código ou conteúdo central do projeto.
- Subpastas específicas do domínio.
- Modelos, schemas, componentes, ativos e dados centrais.
- Tudo que é específico do projeto e não da governança do repositório.
- `readme.md` obrigatório na materialização inicial.

---

## 5. Regras de `.cursorrules`

A `.cursorrules` deve deixar claro, no mínimo, os seguintes pontos:

### 5.1 Comportamento do agente
- Ser objetivo.
- Ser consistente.
- Ser disciplinado com o repositório.
- Não inventar requisitos.
- Não extrapolar escopo.

### 5.2 Honestidade
- Dizer quando não sabe.
- Distinguir fato de suposição.
- Não afirmar validação que não ocorreu.
- Não fingir que entendeu algo que não está documentado.

### 5.3 Dados que a resposta deve mostrar
Toda resposta relevante deve privilegiar:
- o que foi alterado;
- o que foi validado;
- o que ficou pendente;
- quais arquivos foram impactados;
- qual o próximo passo;
- quais documentos justificam a ação.
- usar os dados do arquivo `.prompt-status` para mostrar nº da interação, tempo de processamento e modelos de linguagem usados na tarefa: `> Resposta do Cursor nº {Nn}, usando {LLMs}, com duração de {mm:nn}.`

### 5.4 Leitura condicional
Não ler a raiz inteira em todo prompt.
- **Sempre:** `.cursorrules` + `.prompt-status` (exceto Commit+Push exclusivo).
- **Sob pedido explícito:** CCIA/handoff `@` indicado pelo usuário.
- **Se implementar/documentar:** `spec-root.md` / `rules.md` / trechos de `flow.md`.
- **Se scripts:** `rules-scripts.md`.
- **Se entrega material:** `status.md` / `timeline.md`.
- **Se spec ativa em `specs/to-do/`:** a spec manda no escopo.

### 5.5 Regras de bloqueio
Se faltar contexto, houver contradição ou escopo indefinido, o agente deve pausar e pedir esclarecimento.

### 5.6 Regras de documentação
Mudanças relevantes devem refletir em documentação, status e timeline.

### 5.7 Regras de scripts de instalação
Todo script de instalação deve suportar, quando aplicável, um parâmetro `--uninstall` que execute a remoção reversa do que o script instalou, preservando o comportamento esperado e evitando efeitos colaterais não documentados.

### 5.8 Regras de input interativo
Sempre que o usuário precisar tomar uma escolha, o script deve exibir uma lista numerada de opções e aguardar que ele digite o número correspondente.

### 5.9 Convenção de escolha
- `0` significa sempre `não`, `false` ou `no`.
- `1` significa sempre `sim`, `true` ou `yes`.
- Pressionar `Enter` sem digitar nada deve selecionar a opção default documentada.
- A entrada deve ser validada antes de continuar.
- Entrada inválida deve gerar novo prompt claro.

### 5.10 Regras de `.prompt-status`

Arquivo mínimo (somente estas chaves):

```text
current_prompt_number = N
current_prompt_start_time = ISO-8601-com-offset
```

#### Momento da atualização
- **Entrada (obrigatório):** no início de cada resposta, ler e atualizar.
- **Saída (proibido):** não atualizar ao finalizar.

#### Fluxo na entrada
1. Ler `.prompt-status`.
2. Duração do prompt anterior = `agora − current_prompt_start_time` (útil para o rodapé do turno que acabou / auditoria mental; **não** precisa ser persistida no arquivo).
3. Incrementar `current_prompt_number`.
4. Gravar `current_prompt_start_time` = agora.

#### Exceção — pedido exclusivo de Commit + Push
Não alterar `.prompt-status` na entrada nem na saída.

#### Rodapé da resposta
`> Resposta do Cursor nº {Nn}, usando {LLMs}, com duração de {mm:nn}.`  
`Nn` = `current_prompt_number`; duração do turno atual = `agora − current_prompt_start_time`. LLM não fica no arquivo — informar o modelo da sessão.

### 5.11 Handoff CCIA multi-máquina

O histórico de chat do Cursor **não** é versionado no GitHub. A ponte é o **CCIA** em `prompts/`, sincronizado por commit/push.

#### Propósito
Continuidade entre hosts. `.prompt-status` só numera e ancora tempo; `status.md` / `timeline.md` são estado do projeto — **não substituem** o CCIA.

#### Quando gravar
- Após prompt **relevante** (entrega, decisão, diagnóstico, alteração).
- **Exceção:** Commit+Push exclusivo → não criar CCIA.

#### Quando ler (importante)
- **Somente** se o usuário pedir **explicitamente** (ex.: “estava no PC, agora no notebook — analise `@prompts/...`”).
- **Proibido** ler handoff/CCIA automaticamente só por mudança de hostname ou `git pull`.

#### Nomenclatura (hífen; nunca underscore)

```text
YYYY-MM-DD-NN-<hostname>-<resumo-curto>.md
```

| Parte | Regra |
|---|---|
| `YYYY-MM-DD` | Data local |
| `NN` | `current_prompt_number` (padding só se o projeto já usar) |
| `hostname` | Hostname curto ASCII |
| `resumo-curto` | 3–6 palavras kebab-case, sem acentos |

#### Conteúdo mínimo
Título `# CCIA — …`; data/hora + hostname; pedido; feito/decisões; arquivos; validações; pendências; próximo passo. Sem segredos/PII.

#### Handoff diário
Quando o usuário pedir "handoff" / "fechar sessão": `prompts/YYYY-MM-DD-handoff-<hostname>.md` (estado, bloqueios, onde paramos, CCIAs do dia, próximo passo único).

#### Idioma
PT-BR.

### 5.12 Performance e disciplina de trabalho
- Um prompt = um modo (`explorar` | `implementar` | `corrigir` | `documentar` | `commit+push`).
- Orçamento de `@`: arquivo pontual; evitar pastas grandes e CCIAs antigos.
- Anti-refactor espontâneo.
- Limite de exploração (~8 buscas sem progresso → pause com opções).
- DoD antes de declarar pronto.
- Spec ativa em `specs/to-do/` manda no escopo.
- `.cursorignore` obrigatório na materialização.
- Norma do agente: `.cursorrules` na raiz; **não** exigir `.cursor/rules/` neste template.

---

## 6. Regras de `flow.md`

O `flow.md` deve orientar a sequência de trabalho no repositório.

### Estrutura mínima
1. Identificar modo de tarefa.
2. Leitura condicional (ver §5.4).
3. Se o usuário pediu CCIA/handoff: ler só os `@` indicados.
4. Atualizar `.prompt-status` na entrada (mínimo; §5.10) — exceto Commit+Push exclusivo.
5. Executar só o escopo; sem refactor espontâneo.
6. Validar ou declarar limitação.
7. Atualizar `status.md` / `timeline.md` se material.
8. Gravar CCIA se relevante (§5.11).
9. Responder com DoD + rodapé.

### Regras
- Não ler a raiz inteira por padrão.
- Não ler CCIA/handoff sem pedido explícito.
- Não atualizar `.prompt-status` na saída.
- Em Commit+Push exclusivo: não alterar `.prompt-status` nem criar CCIA.
- Spec ativa tem prioridade de escopo.

---

## 7. Regras adicionais para scripts

Todo script de instalação deve oferecer um modo de desinstalação reversa, preferencialmente por `--uninstall` ou equivalente documentado.

### Regras
- O modo de desinstalação deve desfazer exclusivamente as alterações realizadas pelo script.
- O modo de desinstalação deve preservar conteúdo que não foi criado por ele.
- O modo de desinstalação deve falhar de forma segura se não puder reverter algo integralmente.
- Se o script instalar, configurar, registrar ou copiar algo, precisa existir caminho documentado para desfazer isso.
- A reversão deve ser previsível, explícita e segura.

### Regra de input do usuário
Sempre que o usuário precisar tomar uma escolha, o script deve exibir uma lista numerada de opções e aguardar que ele digite o número correspondente.

### Convenção obrigatória de seleção
- `0` significa sempre `não`, `false` ou `no`.
- `1` significa sempre `sim`, `true` ou `yes`.
- Pressionar `Enter` sem digitar nada deve selecionar a opção default documentada.
- O script deve validar a opção escolhida antes de seguir.
- Se a entrada for inválida, o script deve repetir a solicitação de forma clara.

---

## 8. Regras de adaptação por tipo de projeto

### 8.1 Software
Pode incluir `src/`, `tests/`, `build/`, `packages/`, `migrations/`, `api/` e similares dentro de `/core` ou de subestruturas apropriadas.

### 8.2 Hardware
Pode incluir `cad/`, `bom/`, `schematics/`, `firmware/`, `manufacturing/` dentro de `/core`.

### 8.3 Sistema operacional
Pode incluir `profiles/`, `policies/`, `scripts/`, `debs/`, `rpm/`, `services/` dentro de `/core`.

### 8.4 Impressão 3D
Pode incluir `models/`, `slicing/`, `profiles/`, `materials/`, `test-parts/` dentro de `/core`.

### 8.5 Projetos híbridos
Podem combinar estruturas, desde que a raiz documental permaneça consistente e `/core` concentre o conteúdo específico do projeto.

---

## 9. Regras para o Cursor ao criar o repositório

### 9.1 Materialização a partir deste documento (pasta vazia)

Quando o operador pedir para criar o repositório template (ou equivalente) **somente** com base neste arquivo:

1. Criar **toda** a árvore canônica da §2.1 (hífen nos nomes; nunca underscore).
2. Preencher cada arquivo da raiz com o wireframe da §4 e as regras das §5–§7 e §5.10–§5.11.
3. Incluir cópia deste `spec-project-bootstrap.md` na raiz.
4. Inicializar `.prompt-status` (template da §11) antes do primeiro prompt útil.
5. Criar `prompts/readme.md` (CCIA + colas oficiais) e `specs/optional/` (catálogo opt-in, incl. `bootstrap-personalizar-projeto.md`).
6. Criar `.cursorignore` e `validate-structure.sh` / `.ps1`.
7. Rodar a validação estrutural e corrigir até passar.
8. Preencher `status.md` e `timeline.md` com o evento de criação.
9. **Não** inventar pastas fora do padrão; domínio futuro em `/core`.
10. **Não** exigir `.cursor/rules/`; usar `.cursorrules` na raiz.

O repositório só está materializado quando a árvore canônica existe e o validador estrutural passa.

### 9.2 Regras gerais

O Cursor deve:

- reconhecer a natureza do projeto;
- criar a raiz documental mínima **e** a árvore canônica da §2.1;
- preencher os arquivos com wireframes adequados ao domínio;
- manter consistência entre `spec-project-bootstrap.md`, `spec-root.md`, `rules.md`, `.cursorrules`, `.prompt-status`, `flow.md`, `rules-scripts.md` e `prompts/readme.md`;
- usar **hífen** (`-`) nos nomes dos arquivos de governança da raiz (nunca underscore);
- não confundir arquivo de visão com arquivo operacional;
- manter `status.md` e `timeline.md` vivos desde o início;
- colocar tudo que é específico do projeto sob `/core` sempre que aplicável;
- inicializar `.prompt-status` mínimo (2 campos) antes do primeiro prompt útil;
- garantir CCIA documentado (gravar relevante; ler só sob pedido explícito).

---

## 10. Critério de completude

Um novo repositório está realmente pronto quando:

1. A árvore canônica da §2.1 existe.
2. `validate-structure` (`.sh` / `.ps1`) passa sem faltas.
3. O Cursor consegue responder, sem ambiguidade:
- o que o projeto é;
- quais são as regras;
- como operar com leitura condicional e DoD;
- como validar;
- como documentar progresso;
- onde ficam as referências e `/core`;
- como o agente se comporta (`.cursorrules`);
- como rastrear prompts com `.prompt-status` mínimo;
- como usar CCIA (gravar; ler só sob pedido explícito).

---

## 11. Template de `.prompt-status`

Formato mínimo obrigatório:

```text
# .prompt-status
# Na entrada (exceto Commit+Push exclusivo):
# duração_anterior = agora - current_prompt_start_time
# current_prompt_number += 1
# current_prompt_start_time = agora

current_prompt_number = 1
current_prompt_start_time = 2026-01-01T00:00:00-03:00
```

### 11.1 Campos
- `current_prompt_number` — contador de prompts
- `current_prompt_start_time` — início do prompt atual (ISO-8601 com offset)

### 11.2 Regras
- Horários = hora real do sistema.
- Atualizar **somente na entrada**; **nunca** na saída.
- Commit+Push exclusivo → não alterar.
- Não gravar LLM, status, resumo nem totais neste arquivo.
- Duração do turno no rodapé = `agora − current_prompt_start_time`.

---

## 12. Resumo normativo

`spec-project-bootstrap.md` é a receita reproduzível do template: árvore canônica §2.1, wireframes, `.cursorrules` canônico, `.prompt-status` mínimo (2 campos), CCIA (gravar relevante; ler sob pedido), performance (§5.12), scripts reversíveis, input numerado e domínio em `/core`.
