---
title: Genov
authors: Genov, De Cauwer, Van Kriekinge, Coosemans, Messagie
year: 2024
venue: Applied Energy 353, 121969
pdf: Anexos/Genov.pdf
role: baseline de previsao
tags: [paper]
prioridade: 7
status: por-ler
lido_em: 
confirmado: nao
---

# Genov

## Resumo

Preve a flexibilidade de carregamento de EVs: energia e duracao de permanencia.
Compara metodos baseados em arvores (LightGBM) e em clusters (GMM), e propoe o metodo Similar Sessions.
Testado no ACN-Data.
Mostra que a escolha do modelo depende da quantidade de dados disponiveis.

## Incertezas tratadas

- [[Incerteza: carros eletricos]]

## Temas

- [[Previsao de EVs]]
- [[Comportamento e dados de EVs]]

## Associacao com papers anteriores

Proposta inicial minha, por confirmar apos a leitura:

- [[ACN-Sim]]: usa o ACN-Data
- [[Zhang]]: nao cita o Genov, mas usa GMM para cenarios de chegada e partida, e este paper descreve o GMM com mais detalhe
- [[DiffPLF]]: GMM e LightGBM sao baselines naturais contra modelos de difusao
- [[Amara]]: tambem compara modelos de misturas no ACN-Data, aqui incluindo a chegada e com K escolhido por BIC

## Notas e por fazer

Fonte dos baselines GMM e LightGBM da hipotese dos modelos de difusao.

## O que foi retirado

por preencher

## Metodo e dados

por preencher

## Contribuicao para a tese

por preencher

## Limitacoes e criticas

por preencher

## Perguntas em aberto

por preencher

## Citacoes a usar

por preencher

PDF: [[Genov.pdf]]
