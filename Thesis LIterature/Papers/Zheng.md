---
title: Online Distributed MPC-based Optimal Scheduling for EV Charging Stations in Distribution Systems
authors: Zheng, Song, Hill, Meng
year: 2018
venue: IEEE Transactions on Industrial Informatics (DOI 10.1109/TII.2018.2812755)
pdf: Anexos/Zheng.pdf
role: referencia de MPC de carregamento com fluxo de potencia otimo e restricoes de tensao
tags: [paper]
prioridade: 13
status: por-ler
lido_em: 
confirmado: nao
---

# Zheng

## Resumo

Estrategia online de carregamento para varias estacoes de EVs numa rede de distribuicao, com restricoes de tensao e de fluxo nas linhas.
O problema e um fluxo de potencia otimo (OPF) que minimiza o custo de energia do sistema, resolvido num horizonte deslizante com a informacao mais recente.
O OPF e convexificado por uma relaxacao convexa baseada no modelo de injecao nos barramentos, o que da o otimo global com rapidez.
A resolucao e distribuida entre estacoes (privacidade e interesse economico de cada uma).
A potencia da estacao e repartida pelos EVs com uma regra difusa que garante a carga completa a partida.
Validado num sistema IEEE de 15 barramentos modificado, com estacoes residenciais e comerciais e geracao distribuida.

## Incertezas tratadas

- [[Incerteza: carros eletricos]]

## Temas

- [[Restricoes de tensao e rede]]
- [[MPC para carregamento]]

## Associacao com papers anteriores

Proposta inicial minha, por confirmar apos a leitura:

- [[Thurner]]: o Zheng da a formulacao de rede dentro do controlador, o Thurner a ferramenta (pandapower) para a validar em malha fechada
- [[Lee]]: o ACN so tem limites de corrente por recurso, o Zheng acrescenta tensao nos barramentos
- [[Zhang]] e [[Engel]]: MPC de EVs sem rede, o Zheng acrescenta rede mas com muito menos modelo de sessoes
- [[Saleem]]: tambem tem tensao no ponto de ligacao, mas so controla a bateria

## Notas e por fazer

Ficheiro vindo do buffer. Li o resumo, a introducao, a formulacao e os casos de estudo, sem verificar todas as equacoes.
Confirmar: se a relaxacao convexa serve a rede desequilibrada que o pandapower permite, e como o Zheng trata a regra difusa de distribuicao face ao distribuidor do Engel.

## O que foi retirado

por preencher

## Metodo e dados

Modelo de rede de injecao nos barramentos com relaxacao convexa (restricoes de segunda ordem), horizonte deslizante.
Cargas PQ constantes e geracao renovavel a fator de potencia unitario, valor esperado horario.
Os erros de previsao de carga (menos de 1%) e de geracao distribuida (menos de 5%) a 1 hora sao ignorados.
A incerteza dos EVs e de dois tipos: chegadas incertas e saidas subitas, tratadas pela atualizacao do MPC.
Caso 1: IEEE de 15 barramentos modificado, quatro estacoes (barramentos 3, 8, 9 e 14), geracao nos barramentos 6, 9 e 11.
Teste de incerteza: 20 cenarios com 10% de erro aleatorio sobre o padrao de carga previsto, comparando MPC, despacho offline sem MPC e otimo com conhecimento perfeito.
Caso 2: segundo sistema com resolucao distribuida. Os dados sao sinteticos, sem ACN-Data.

## Contribuicao para a tese

por preencher

## Limitacoes e criticas

por preencher

## Perguntas em aberto

por preencher

## Citacoes a usar

por preencher

PDF: [[Zheng.pdf]]
