---
tags: [topic, decisao]
estado: hipotese
---

# Esqueleto da formulacao

Nota-sintese de onde vem cada parte da formulacao matematica do MPC da tese.
Cada componente aponta para o paper que da a melhor referencia, com a razao.
Estado: hipotese de trabalho.
O codigo ainda nao foi criado.

## Componentes

### Modelo dos EVs

Dois modelos complementares, que se combinam.

- [[Engel]]: modelo por carregador em espaco de estados. Energia e capacidade de cada carregador sao estados, a potencia e a entrada, e chegadas e partidas sao perturbacoes.
- [[Engel]]: cada sessao tem carregador, chegada, partida estimada, energia inicial, capacidade disponivel e energia desejada. Inclui V2G e degradacao.
- [[Engel]]: mapeia bem para as EVSEs do ACN-Sim.
- [[Zhang]]: formulacao por evento. Cada sessao e o tuplo chegada, partida e energia, com a sua variavel de potencia e janela de chegada e partida.
- Distingue eventos correntes (ligados agora) de eventos futuros (a prever).
- Os correntes so tem incerteza na partida e na energia declaradas pelo utilizador.
- Os futuros tem incerteza em todos os parametros, e o numero de eventos tambem e incerto.
- A matriz de conexao M liga cada evento corrente a uma porta e e um parametro conhecido em cada passo.

### Arquitetura do controlador

- [[Engel]]: dois niveis, agregador e distribuidor, com retorno do distribuidor ao agregador.
- Estados de energia e capacidade por carregador, chegadas e partidas como perturbacoes.
- Degradacao das baterias como termos do custo.
- Problema convexo (QP) com variaveis continuas.
- Fraqueza: inclui termica do edificio, CHP e gas, que a tese nao precisa.

### Previsor de chegadas, partidas e energia

- [[Amara]]: triplo (chegada, duracao, energia) por sessao, numero de sessoes mais modelo de misturas.
- [[Engel]]: GMM sobre o ACN JPL, com permanencia condicionada a chegada.
- [[Zhang]]: GMM para cenarios de eventos futuros, mas o treino nao esta descrito.
- Ver os papers de difusao para a substituicao do GMM: [[DiffPLF]], [[Li]].
- Baselines de previsao: [[McClone]], [[Genov]]. 

### Sistema integrado e rede

- [[Saleem]]: referencia de MPC estocastico com tensao no ponto de ligacao (custo esperado sobre cenarios, decisao unica).
- So controla a bateria, os EVs sao procura. Leitura adiada por decisao, baixa prioridade.
- Rede (tensao e corrente por barramento): por decidir, ligando com [[Restricoes de tensao e rede]].

### Incerteza de PV e edificio

- Ver [[Incerteza: paineis solares]] e [[Incerteza: edificio]].

### Solver e ferramentas

- Por decidir quando se criar o codigo.
- Zhang e Engel usam Gurobi. Zhang escreve o modelo em Pyomo e Engel em MATLAB com PARODIS.
- Alternativas a avaliar: CVXPY e HiGHS.

## Relacoes entre os papers

- [[Engel]] complementa [[Zhang]]: melhor arquitetura e sistema integrado, previsao mais fraca e menos documentada.
- [[Zhang]] da uma formulacao por evento simples, mas so trata EVs. O [[Engel]] da um modelo por carregador em espaco de estados e mais completo (V2G e degradacao).
- Nenhum dos dois trata a rede.
- [[Amara]] e a fonte da previsao deterministica do baseline de [[Zhang]].

## Por decidir

- Se os cenarios entram por media (Engel), por um MPC por cenario (Zhang) ou por MPC estocastico.
- Tipo de horizonte: deslizante de comprimento fixo (Engel) ou que encolhe (Zhang).
- Desenho monolitico (uma variavel por EV) ou hierarquico (agregador e distribuidor). Ver [[Hipotese]].
- Como a matriz M se usa para somar potencias por barramento ou fase.
