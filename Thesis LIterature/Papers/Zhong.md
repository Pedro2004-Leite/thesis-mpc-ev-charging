---
title: Data-driven distributionally robust MPC using the Wasserstein metric
authors: Zhong, del Rio-Chanona, Petsagkourakis
year: 2021
venue: arXiv 2105.08414 (preprint, math.OC)
pdf: Anexos/Zhong.pdf
role: alternativa ao tratamento de cenarios no MPC (MPC distributionalmente robusto)
tags: [paper]
prioridade: 17
status: por-ler
lido_em: 
confirmado: nao
---

# Zhong

## Resumo

Propoe um MPC para sistemas lineares com perturbacao aditiva que usa so amostras da perturbacao, sem assumir a sua distribuicao.
As amostras formam uma distribuicao empirica, e em volta dela define-se um circulo de Wasserstein com um raio.
As restricoes tem de valer para a pior distribuicao dentro desse circulo.
O controlador e uma lei afim das perturbacoes passadas, e o problema fica convexo (um programa conico), com garantia para poucas amostras e com factibilidade recursiva.
Testado em dois exemplos pequenos: um sistema massa-mola e um pendulo invertido.
O codigo esta em https://github.com/OptiMaL-PSE-Lab/Data-driven-distributionally-robust-MPC.
Nome parecido com o [[Zhang]], mas e outro paper e outro assunto.

## Incertezas tratadas

Generica: perturbacao aditiva na dinamica, sem uma fonte especifica.
Poderia aplicar-se a perturbacoes que entram somando no balanco de potencia, como o PV e a carga do edificio.

## Temas

- [[MPC distributionalmente robusto]]
- [[MPC estocastico]]

## Associacao com papers anteriores

Proposta minha, por confirmar apos a leitura:

- [[Engel]]: no agregador do Engel, as chegadas e partidas entram como perturbacoes que somam, o que pode ajustar-se a este formato
- [[Zhang]]: o Zhang faz a media dos controlos dos cenarios, e este paper trata a incerteza das amostras de forma mais rigorosa
- [[Saleem]]: tambem MPC com cenarios, mas com custo esperado e sem garantia para poucas amostras
- [[DiffPLF]] e [[Li]]: geradores que dariam as amostras da perturbacao
- [[Brown]] e [[Grob]]: MPC estocastico com previsao probabilistica de PV

## Notas e por fazer

Alternativa para depois, nao e prioridade.
Pode ser avaliada quando o MPC por cenarios estiver estavel, como comparacao de como usar as amostras do previsor.
O codigo e uma foto de investigacao: usa cvxpy e mosek, e nao encontrei licenca. Ver [[MPC distributionalmente robusto]].

## O que foi retirado

por preencher

## Metodo e dados

O sistema e linear e invariante no tempo, com a perturbacao a entrar somando na dinamica.
As amostras da perturbacao formam a distribuicao empirica, e o raio do circulo de Wasserstein diz quanto se desconfia dessas amostras.
O objetivo e quadratico, e as restricoes de estado sao limitadas na esperanca, para a pior distribuicao do circulo.
O controlo e uma lei afim das perturbacoes passadas.
A reformulacao e um programa conico, resolvido a cada passo.
Nos exemplos usa horizonte de 5 passos e, no maximo, as 10 amostras mais recentes.
A perturbacao dos exemplos e sintetica, do tipo 3 vezes o seno de uma normal.

## Contribuicao para a tese

por preencher

## Limitacoes e criticas

Sistemas lineares e invariantes, e perturbacao aditiva.
Exemplos pequenos e sinteticos, sem nada de EVs nem de redes.
Cresce com o numero de amostras, e por isso usam so as 10 mais recentes.
A incerteza dos EVs (quem chega e quando sai) nao e uma perturbacao aditiva, e teria de ser reformulada.
O trabalho futuro que os autores indicam e estender a sistemas nao lineares.

## Perguntas em aberto

por preencher

## Citacoes a usar

por preencher

PDF: [[Zhong.pdf]]
