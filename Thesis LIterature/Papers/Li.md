---
title: DiffCharge - Generating EV Charging Scenarios via a Denoising Diffusion Model
authors: Li, Xiong, Chen
year: 2024
venue: arXiv 2308.09857 (v2, jan 2024)
pdf: Anexos/Li.pdf
role: geracao de cenarios de EVs por difusao no ACN-Data (citado por Zhang)
tags: [paper]
prioridade: 9
status: por-ler
lido_em: 
confirmado: nao
---

# Li

## Resumo

DiffCharge e um modelo de difusao (DDPM) que gera cenarios de carregamento de EVs, ao nivel da bateria e ao nivel da estacao, como series temporais.
Usa multi-head self-attention e condicoes previas para captar as correlacoes temporais de cada tipo de bateria ou estacao.
Validado no ACN-Data, contra GMM, VAEGAN e TimeGAN, e testado num problema de operacao de EVs no mercado day-ahead.
Citado por [[Zhang]] (ref. 22) como o uso de difusao para prever o carregamento de EVs.
Mesmo grupo de autores do [[DiffPLF]].

## Incertezas tratadas

- [[Incerteza: carros eletricos]]

## Temas

- [[Modelos de difusao]]
- [[Previsao de EVs]]
- [[Previsao probabilistica]]
- [[Comportamento e dados de EVs]]

## Associacao com papers anteriores

Proposta inicial minha, por confirmar apos a leitura:

- [[DiffPLF]]: mesmos autores, mesma familia de difusao, aqui para gerar cenarios em vez de previsao probabilistica
- [[Zhang]]: Zhang cita-o como difusao aplicada ao carregamento de EVs
- [[Genov]]: GMM como baseline, e usa o mesmo ACN-Data
- [[Engel]]: GMM para cenarios, que o DiffCharge contesta por limitar a capacidade de representacao
- [[ACN-Sim]]: mesmo dataset de origem (ACN-Data)

## Notas e por fazer

Aparece nas referencias de Zhang (ref. 22).
Ver a comparacao com o GMM e a seccao de aplicacao ao mercado day-ahead, que e o equivalente a ligar ao controlador.

## O que foi retirado

por preencher

## Metodo e dados

DDPM com self-attention e condicionamento, gera perfis de carga diarios agregados por estacao e perfis de sessoes individuais.
Dados do ACN-Data (California), com perfis diarios extraidos por agregacao das sessoes.
Baselines: GMM, VAEGAN e TimeGAN.

## Contribuicao para a tese

por preencher

## Limitacoes e criticas

por preencher

## Perguntas em aberto

por preencher

## Citacoes a usar

por preencher

PDF: [[Li.pdf]]
