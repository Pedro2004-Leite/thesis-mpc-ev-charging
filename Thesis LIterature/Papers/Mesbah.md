---
title: Stochastic Model Predictive Control - An Overview and Perspectives for Future Research
authors: Mesbah
year: 2016
venue: IEEE Control Systems Magazine 36(6), 30-44
pdf: Anexos/Mesbah.pdf
role: enquadramento de MPC estocastico para o estado da arte
tags: [paper]
prioridade: 11
status: por-ler
lido_em: 
confirmado: nao
---

# Mesbah

## Resumo

Revisao de MPC estocastico (SMPC), a abordagem que usa a distribuicao da incerteza em vez de um conjunto limitado, como no MPC robusto.
Explica que o MPC normal e determinista e que o MPC robusto cobre o pior caso de um conjunto limitado, o que pode ser conservador.
O SMPC usa distribuicoes de probabilidade e restricoes probabilisticas (chance constraints), e procura um compromisso entre o objetivo e a satisfacao das restricoes.
Para sistemas lineares separa tres escolas: tubos estocasticos, politica de controlo afim nas perturbacoes, e programacao estocastica com amostras.
Para sistemas nao lineares: amostras, aproximacao por misturas gaussianas, polinomios de caos e a equacao de Fokker-Planck.
Sobre as amostras, diz que nao exigem convexidade, mas podem ser caras por precisarem de muitas, e fala da abordagem por cenarios, que limita o numero de cenarios necessarios.
Aponta problemas em aberto, como factibilidade recursiva e estabilidade.

## Incertezas tratadas

Generica: perturbacoes e ruido de medida com distribuicao conhecida, sem fonte especifica.

## Temas

- [[MPC estocastico]]
- [[MPC]]

## Associacao com papers anteriores

Proposta minha, por confirmar apos a leitura:

- [[Saleem]], [[Brown]] e [[Grob]]: SMPC por cenarios ou programacao dinamica, que este paper enquadra
- [[Engel]] e [[Zhang]]: usam cenarios mas com media dos cenarios ou dos controlos, o que fica fora do SMPC em sentido estrito
- [[Zhong]]: MPC distributionalmente robusto, entre o robusto e o estocastico. O Zhong cita outro trabalho de Mesbah, de 2014

## Notas e por fazer

Uso no relatorio: secao 2, para enquadrar os papers de MPC estocastico do vault.
Ler a introducao, a formulacao geral e a parte das abordagens por amostras e por cenarios.
Os problemas em aberto ajudam a justificar o que a tese deixa de fora.

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

PDF: [[Mesbah.pdf]]
