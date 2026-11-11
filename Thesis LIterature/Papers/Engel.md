---
title: Hierarchical Economic Model Predictive Control Approach for a Building Energy Management System With Scenario-Driven EV Charging
authors: Engel, Schmitt, Rodemann, Adamy
year: 2022
venue: IEEE Transactions on Smart Grid 13(4), 3082-3093
pdf: Anexos/Engel.pdf
role: referencia de sistema integrado com cenarios GMM (citado por Zhang)
tags: [paper]
prioridade: 3
status: lido
lido_em: 2026-11-10
confirmado: sim
---

# Engel

## Resumo

EMPC hierarquico para o EMS de um edificio comercial com PV, bateria estacionaria, CHP, climatizacao e carregadores de EVs com V2G.
Um agregador planeia o EMS com uma vista agregada dos carregadores, e um distribuidor reparte a potencia pelos carregadores individuais.
Ambos os niveis usam EMPC com custo monetario, conforto termico, satisfacao de carga dos EVs e degradacao da bateria.
O comportamento dos EVs e previsto por cenarios gerados de GMMs ajustados ao dataset ACN JPL, e depois promediados num unico cenario medio.
Citado por [[Zhang]] como exemplo de cenarios amostrados de GMMs.

## Incertezas tratadas

- [[Incerteza: carros eletricos]]
- [[Incerteza: edificio]]
- [[Incerteza: paineis solares]]

## Temas

- [[MPC para carregamento]]
- [[Sistemas integrados PV+bateria+EV]]
- [[Comportamento e dados de EVs]]

## Associacao com papers anteriores

Relacao com o esqueleto da formulacao: da a arquitetura em dois niveis e o modelo de EVs por carregador em espaco de estados (ver [[Esqueleto da formulacao]]).
Complementa o [[Zhang]]: melhor arquitetura e sistema integrado, previsao mais fraca e menos documentada.

Proposta inicial minha, por confirmar apos a leitura:

- [[Zhang]]: Zhang cita-o como exemplo de GMM para gerar cenarios de EVs
- [[Genov]]: GMM para chegadas, mesma familia de modelo
- [[ACN-Sim]]: usa o mesmo dataset ACN (JPL)
- [[Saleem]]: outro sistema integrado PV+bateria+EV, aqui com hierarquia em vez de cenarios completos
- [[Amara]]: mesma familia de GMM, mas com mistura conjunta e K escolhido por BIC, mais bem documentada

## Notas e por fazer

Aparece nas referencias de Zhang (ref. 20).
Lido parcialmente: modelo (seccao II), comportamento e cenarios (seccao III), custo e conclusoes. A avaliacao (seccao IV) nao foi lida em detalhe.
O paper e forte na arquitetura e fraco na previsao. Ver [[Esqueleto da formulacao]].
Nao e MPC estocastico em sentido estrito: gera N_S = 100 cenarios, faz a media e corre um unico EMPC deterministico com o cenario medio.
Por isso nao esta ligado ao tema MPC estocastico. O Zhang tambem nao, porque corre um MPC por cenario e faz a media dos controlos.

## O que foi retirado
Em vez de rodar o algoritmo várias vezes para cada cenário, ele amostra vários cenários e depois faz o averaging, isto não é MPC estocástico, é MPC deterministico. 
De forma semelhante a Zhang, o comportamento dos EVs é expresso por 3 parâmetros: o tempo de chegada, o tempo de permanência/ partida e a energia requerida. 
Para o número de eventos, conclui-se que a distribuição era puramente gaussiana. 
Para o tempo de chegada utilizou-se um GMM de 3 componentes. 
![[Pasted image 20261110162943.png]]
Concluiu-se que o tempo de permanência estava correlacionado com o tempo de chegada. 
![[Pasted image 20261110162839.png]]

Para o tempo de permanência, define o GMM com 2 componentes em janelas de 2 horas. 
(Correcao: o paper agrupa as sessoes em intervalos de 0,5 h pela hora de chegada, e ajusta um GMM de 2 componentes por intervalo.)
Para a energia necessária, dá fit a um GMM com 6 componentes. 
Aqui a energia entregue em sessões longas é utilizada como proxy para a energia requerida e foi isso que foi utilizado para dar fit na GMM. 

## Metodo e dados

EMPC em dois niveis (agregador e distribuidor), cenario medio a partir de GMM com 3 componentes (chegada, permanencia, energia).
Dados do edificio de Offenbach (2018) e 9189 sessoes de EV geradas a partir do ACN JPL.
Avaliacao anual com 5 criterios (custo, conforto, satisfacao de carga, degradacao do EV e da bateria estacionaria).

O Horizonte utilizado é de 48 deslizante (sliding), com passo = 0.5h. Para cada passo o 
algoritmo recalcula as sessões previstas no futuro.
Os veiculos que lá estão jã foram observados.

O custo aqui contabilizado é puramente um custo económico e o custo associado à degradação das baterias, não existe custo associado ao pico. 
(Correcao: o custo monetario inclui um custo de pico, J_mon,peak = c_grid,peak x max_k(0, P_grid(k) - P_grid,peak(0)), equacao 7. O que nao existe e custo de rede.)

O problema é formulado como um problema quadrático com restrições lineares (QP). 


Engel modela os carregadores como estados do modelo e as sessões de carregamento como perturbações, face a Zhang é muito diferente. 
## Contribuicao para a tese

O modelo utilizado para os EVs e arquitetura de dois niveis. 

## Limitacoes e criticas

Quais foram os critérios para escolher os parâmetros dos GMMs? 
O cenário médio faz perder muita informação 
Dados de EV são gerados pelas próprias GMMs que o previsor usa.
De forma semelhante a Zhang os GMMS não estão bem documentados. 
O input do utilizador é centrado no valor real puramente modelado por uma gaussiana, o que é demasiado otimista. 
Não possui rede 

## Perguntas em aberto

- Que criterio escolheu 3, 2 e 6 componentes, e quanto dura uma sessao para ser considerada longa?
- Que periodo do ACN JPL usou para ajustar os GMMs?
- Como se comporta o controlador com dados reais de sessoes, em vez de sessoes geradas pelo mesmo GMM?
- Como entra a rede (tensao e corrente por barramento) numa arquitetura de dois niveis como esta?

## Citacoes a usar

- "We then average these scenarios and use this averaged behaviour scenario for the control of the EMS." (seccao III, p. 7)
- "(20) is a convex quadratic program (QP) with only continuous variables" (seccao II, p. 6)
- "EV usage behaviour is inherently stochastic, since in general, no exact a priori knowledge about EVs is available." (seccao III, p. 7)

PDF: [[Engel.pdf]]
