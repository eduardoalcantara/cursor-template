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
Todo projeto deve conter um arquivo `.prompt-status` na raiz para rastrear a execução de cada prompt/tarefa do Cursor AI.

### 1.7 Rastreamento de execução é obrigatório
Antes de executar um prompt, o Cursor AI deve ler `.prompt-status`.

**Regra de atualização (entrada apenas):** o agente atualiza `.prompt-status` **somente no início da resposta** (entrada do prompt), **nunca no encerramento** (saída da resposta). Na entrada, o prompt anterior (se houver) é finalizado e movido para `[last]`; o prompt atual é registrado em `[current]` com status `running`, LLM, horário de início e resumo.

**Exceção — Commit + Push:** quando o pedido do usuário for **exclusivamente** versionamento Git (`commit`, `push`, `commit + push` ou equivalente), **não** atualizar `.prompt-status` (nem na entrada). Objetivo: evitar commit/push desnecessário só por causa do rastreio.

### 1.8 Continuidade multi-máquina via CCIA
O histórico de chat do Cursor **não** viaja com o Git. Todo repositório materializado a partir deste bootstrap deve nascer com `prompts/` preparado para **CCIA** (Conversas com o Agente / handoff) e handoff diário por hostname (ver §5.11), para que outro PC retome o raciocínio após `git pull`.

---

## 2. Estrutura raiz padrão

Todo novo repositório deve possuir, sempre que aplicável, os seguintes itens na raiz:

- `.gitignore`
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
- `specs/` (`to-do/`, `done/`)
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
prompts/bootstrap-personalizar-projeto.md
resources/readme.md
resources/downloads/.gitkeep
core/readme.md
```

Depois de criado, `scripts/validation/validate-structure.sh` (ou `.ps1`) deve passar com zero faltas.

---

## 3. Função dos arquivos da raiz

### 3.1 `.gitignore`
Define o que não deve entrar no versionamento.

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
Rastreia o prompt em andamento, o último prompt concluído, o LLM utilizado, a duração e os acumulados de execução. Atualização **apenas na entrada** de cada resposta (ver §5.10 e §11).

### 3.13 `spec-template.md`
Fornece o molde para novas specs do projeto.

### 3.14 `rules-scripts.md`
Define a governança de criação e execução de scripts, incluindo organização, input, cabeçalho, autodetecção da raiz, UX operacional e desinstalação reversa.

### 3.15 `docs/`
Armazena documentação técnica, operacional, normativa e de produto.

### 3.16 `ideas/`
Armazena hipóteses, rascunhos, propostas e ideias ainda não formalizadas.

### 3.17 `specs/`
Armazena especificações formais do projeto, com subpastas obrigatórias `to-do/` e `done/` (cada uma com `readme.md`).

### 3.18 `references/`
Armazena referências locais, engenharia reversa, exemplos e materiais de estudo.

### 3.19 `scripts/`
Armazena scripts de automação, bootstrap, validação e apoio operacional, organizados em `bootstrap/`, `validation/`, `automation/` e `maintenance/`. Em `validation/` devem existir `validate-structure.sh` e `validate-structure.ps1`.

### 3.20 `reports/`
Armazena relatórios de implementação, auditoria, validação e entrega.

### 3.21 `prompts/`
Armazena prompts reutilizáveis, colas e instruções mestre, **e** o handoff CCIA (Conversas com o Agente) por prompt e por dia/hostname — ponte de continuidade entre PCs via Git. Novos repositórios **devem** nascer com `prompts/readme.md` (norma CCIA) e a cola `prompts/bootstrap-personalizar-projeto.md`.

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
- Ordem de leitura obrigatória.
- Fluxo de execução do agente.
- Ordem de decisões.
- Gate de confirmação.
- Checklist de execução.
- Passos de validação.
- Passos de encerramento.
- Leitura de `.prompt-status` no início de cada prompt e atualização **somente na entrada** (nunca na saída).

### 4.5 `rules.md`
- Hierarquia normativa.
- Regras gerais permanentes.
- Regras de escopo.
- Regras de qualidade.
- Regras de documentação.
- Regras de validação.
- Regras de bloqueio.
- Regras de atualização.

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
- Perfil do agente.
- Comportamento esperado.
- Honestidade e bloqueio.
- Regras de resposta.
- Regras de validação.
- Regras de escopo.
- Regras de atualização documental.
- Regras de dados mínimos por resposta.
- Regras de scripts e input.
- Regras de leitura e atualização de `.prompt-status` (entrada apenas; exceção Commit + Push).
- Regras de CCIA / handoff multi-máquina em `prompts/` (ver §5.11).

### 4.12 `.prompt-status`
- Prompt em andamento.
- Último prompt concluído.
- LLM atual e LLM anterior, quando relevante.
- Datas e horários de início e fim.
- Duração da tarefa.
- Status da execução.
- Resumo curto da tarefa.
- Acumulados de prompts e tempo.

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
- Cada spec com escopo e critério de aceite.
- Relacionamento explícito com `spec-root.md`.
- Ordem por domínio ou grupo.

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
- `readme.md` explicando CCIA e colas reutilizáveis (obrigatório na materialização).
- Cola `bootstrap-personalizar-projeto.md` (personalizar placeholders após clonar/criar).
- Prompts reutilizáveis, revisão, grupo e fluxo.
- CCIA por prompt relevante: `YYYY-MM-DD-NN-<hostname>-<resumo-curto>.md`.
- Handoff diário por hostname: `YYYY-MM-DD-handoff-<hostname>.md`.

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

### 5.4 Leitura obrigatória
Antes de agir, o agente deve ler os documentos-raiz relevantes.

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

#### Momento da atualização
- **Entrada (obrigatório):** no **início** de cada resposta, após ler o arquivo, atualizar `.prompt-status`.
- **Saída (proibido):** **não** atualizar `.prompt-status` ao finalizar a resposta, mesmo que a tarefa tenha sido concluída, bloqueada ou falhado.

#### Fluxo na entrada de um prompt normal
1. Ler `.prompt-status`.
2. Se `[current]` contiver dados do prompt anterior (`current_prompt_number` preenchido):
   - Copiar para `[last]` com `last_prompt_end_time` = agora, calcular `last_prompt_duration_seconds`, definir `last_prompt_status` (`success`, `blocked` ou `failed`) e `last_prompt_summary` com base no que foi entregue na interação anterior.
   - Incrementar `total_prompts_tracked` e somar duração em `total_execution_seconds`.
3. Preencher `[current]` para o prompt atual: número incrementado, `current_prompt_start_time` = agora, `current_prompt_status` = `running`, LLM e resumo curto do pedido do usuário.
4. Limpar campos de fim/duração em `[current]` (ficam vazios até a próxima entrada).

#### Exceção — pedido exclusivo de Commit + Push
Quando o usuário pedir **somente** operação Git de versionamento (`commit`, `push`, `commit + push`, `commit e push` ou equivalente, sem outra tarefa de implementação/documentação):
- **Não** ler para atualizar (pode ler para contexto, se útil).
- **Não** alterar `.prompt-status` na entrada **nem** na saída.
- Objetivo: o commit/push do usuário não deve incluir mudança espúria em `.prompt-status`.

#### Rodapé da resposta
- Usar dados de `[last]` (prompt já finalizado na entrada **desta** resposta) ou, se aplicável, estimativa a partir de `[current]`, para o rodapé: `> Resposta do Cursor nº {Nn}, usando {LLMs}, com duração de {mm:nn}.`

### 5.11 Handoff CCIA multi-máquina

O histórico de chat do Cursor **não** é versionado no GitHub. Cada PC físico / instalação começa a conversa do zero. A ponte operacional é o **CCIA** (Conversas com o Agente / handoff de sessão) em `prompts/`, sincronizado por commit/push.

#### Propósito
- Carregar continuidade de raciocínio entre hosts após `git pull`.
- `.prompt-status` numera e mede duração; `status.md` / `timeline.md` registram estado do projeto — **não substituem** o CCIA.

#### Quando gravar
- Após cada prompt **relevante** (entrega, decisão, diagnóstico, alteração de código/docs).
- **Exceção:** pedido **exclusivo** de commit/push → **não** criar CCIA novo (mesma exceção de `.prompt-status`).

#### Nomenclatura (hífen; nunca underscore)

```text
YYYY-MM-DD-NN-<hostname>-<resumo-curto>.md
```

| Parte | Regra |
|---|---|
| `YYYY-MM-DD` | Data local da sessão |
| `NN` | Número do prompt em `.prompt-status` (`current_prompt_number`); zero à esquerda se o projeto já usar (ex.: `027`) — manter consistente |
| `hostname` | Hostname curto / `COMPUTERNAME` da máquina onde o Cursor rodou (ASCII; estável) |
| `resumo-curto` | 3–6 palavras em kebab-case, sem acentos |

Exemplo: `2026-09-06-217-ed-z2-handoff-sysvol-cleanup.md`

#### Conteúdo mínimo do Markdown CCIA
1. Título `# CCIA — …`
2. Data/hora e hostname
3. Pedido do usuário (resumo; sem segredos)
4. O que o agente fez / decidiu
5. Arquivos impactados
6. Validações / limitações
7. Pendências
8. Próximo passo (o que a outra máquina deve ler/fazer ao retomar)

#### Proibido no CCIA
Senha, token, URL completa de webhook, chave privada, dump sensível, PII desnecessária.

#### Handoff diário (recomendado)
No fim do dia de trabalho, ou quando o operador pedir "handoff" / "fechar sessão":

```text
prompts/YYYY-MM-DD-handoff-<hostname>.md
```

Conteúdo: estado atual, decisões abertas, bloqueios, 3–5 bullets de "onde paramos", lista dos CCIA do dia, próximo passo único. É o arquivo que outra máquina deve abrir **primeiro** após `git pull`.

#### Relação com outros artefatos
- `.prompt-status` → numeração e duração (update só na entrada; exceção commit/push).
- `status.md` / `timeline.md` → estado e histórico do projeto.
- Commit/push do CCIA/handoff → mecanismo de sincronização entre PCs.

#### Idioma
Textos do bootstrap e exemplos em **PT-BR** (arquivo, usuário, diretório, atualizar).

---

## 6. Regras de `flow.md`

O `flow.md` deve orientar a sequência de trabalho no repositório.

### Estrutura mínima
1. Ler `spec-root.md`.
2. Ler `rules.md`.
3. Ler `.cursorrules`.
4. Ler `.prompt-status`.
5. Ao retomar noutro host: ler o handoff diário mais recente em `prompts/` (`YYYY-MM-DD-handoff-<hostname>.md`) e CCIAs relevantes do dia.
6. Ler `rules-scripts.md` quando a tarefa envolver scripts.
7. Ler `status.md` e `timeline.md` para contexto atual.
8. Ler `specs/` e `docs/` relevantes.
9. Planejar a entrega.
10. Implementar ou documentar somente o escopo confirmado.
11. Atualizar `.prompt-status` no início da execução (entrada apenas; ver §5.10).
12. Validar o que foi feito.
13. Atualizar `status.md`.
14. Atualizar `timeline.md`.
15. Gravar CCIA em `prompts/` após prompt relevante (ver §5.11); handoff diário quando pedido ou ao fechar sessão.
16. Produzir relatório de entrega.
17. Registrar próximos passos.

### Regras
- Não pular leitura obrigatória.
- Não começar implementação sem contexto.
- Não misturar grupos ou temas sem autorização.
- Encerrar cada tarefa com validação e atualização documental.
- **Não** atualizar `.prompt-status` na saída da resposta; a finalização do prompt ocorre na **entrada** do prompt seguinte.
- Em pedido **exclusivo** de Commit + Push, **não** alterar `.prompt-status` nem criar CCIA novo.
- Ao retomar em outro PC: abrir primeiro o handoff diário em `prompts/`.

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
5. Criar `prompts/readme.md` (CCIA) e `prompts/bootstrap-personalizar-projeto.md`.
6. Criar `validate-structure.sh` e `validate-structure.ps1` que conferem a estrutura mínima.
7. Rodar a validação estrutural e corrigir até passar.
8. Preencher `status.md` e `timeline.md` com o evento de criação.
9. **Não** inventar pastas fora do padrão; domínio futuro em `/core`.

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
- inicializar `.prompt-status` antes do primeiro prompt executado no repositório;
- garantir CCIA / handoff multi-máquina documentado e operacional em `prompts/` (ver §5.11).

---

## 10. Critério de completude

Um novo repositório está realmente pronto quando:

1. A árvore canônica da §2.1 existe.
2. `validate-structure` (`.sh` / `.ps1`) passa sem faltas.
3. O Cursor consegue responder, sem ambiguidade:
- o que o projeto é;
- quais são as regras;
- como operar;
- como validar;
- como documentar progresso;
- onde ficam as referências;
- onde fica o núcleo específico do projeto;
- como o agente deve se comportar;
- como rastrear cada prompt em `.prompt-status` (atualização na entrada; exceção Commit + Push);
- como retomar contexto multi-máquina via CCIA / handoff em `prompts/`.

---

## 11. Template de `.prompt-status`

O arquivo `.prompt-status` deve usar um formato simples de pares `chave = valor`, com seções para andamento, último prompt e acumulados.

### 11.1 Seção de prompt em andamento
- `current_prompt_number`
- `current_prompt_start_time`
- `current_prompt_status`
- `current_prompt_llm`
- `current_prompt_summary`

### 11.2 Seção de último prompt concluído
- `last_prompt_number`
- `last_prompt_start_time`
- `last_prompt_end_time`
- `last_prompt_duration_seconds`
- `last_prompt_status`
- `last_prompt_llm`
- `last_prompt_summary`

### 11.3 Seção de acumulados
- `total_prompts_tracked`
- `total_execution_seconds`

### 11.4 Regras do template
- Os horários devem refletir a hora real do sistema.
- O resumo deve ser curto e objetivo.
- O status deve ser explícito, como `running`, `success`, `blocked` ou `failed`.
- O campo de LLM deve identificar claramente o modelo usado na tarefa.
- O arquivo deve ser atualizado sem perder o histórico recente da execução anterior.
- **Atualizar somente na entrada** de cada resposta do agente; **nunca** na saída.
- Na entrada: finalizar o prompt anterior em `[last]` (se existir) e abrir `[current]` para o prompt atual.
- **Exceção:** pedido exclusivo de Commit + Push → não alterar este arquivo.

---

## 12. Resumo normativo

`spec-project-bootstrap.md` (este documento) é a raiz universal e a **receita reproduzível** para criação de qualquer novo repositório no Cursor a partir de pasta vazia: estrutura documental completa (árvore canônica §2.1), wireframes por arquivo, regras de comportamento do agente, honestidade operacional, suporte a scripts reversíveis, regra de input numerado, fluxo de trabalho explícito, uso obrigatório de `.prompt-status` (atualização na entrada; exceção Commit + Push), handoff CCIA multi-máquina em `prompts/` e centralização do conteúdo específico do projeto em `/core`.
