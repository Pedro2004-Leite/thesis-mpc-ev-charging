---
title: DiffPLF
authors: Li, Xiong, Chen
year: 2024
venue: Electric Power Systems Research 235, 110723
pdf: Anexos/DiffPLF.pdf
role: metodo central da hipotese
tags: [paper]
prioridade: 8
status: por-ler
lido_em: 
confirmado: nao
---

# DiffPLF

## Resumo

Modelo de difusao condicional para previsao probabilistica da carga de EVs.
Condicionamento por cross-attention e afinacao orientada a tarefa.
Reporta ganhos de 39.58% em MAE e 49.87% em CRPS face ao metodo convencional.

## Incertezas tratadas

- [[Incerteza: carros eletricos]]

## Temas

- [[Previsao de EVs]]
- [[Previsao probabilistica]]
- [[Modelos de difusao]]

## Associacao com papers anteriores

Proposta inicial minha, por confirmar apos a leitura:

- [[Zhang]]: cita-o (ref. 13). Ambos usam difusao para incerteza de EVs, com alvos diferentes (carga agregada vs inputs dos utilizadores)
- [[Genov]]: baselines GMM e LightGBM
- [[Ran]]: contraste com previsao pontual
- [[Cheng]]: contraste com previsao pontual

## Notas e por fazer

Verificar o que e previsto: carga agregada em serie temporal, nao sessoes individuais.

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

PDF: [[DiffPLF.pdf]]
