---
title: A New Real-Time Smart-Charging Method Considering Expected Electric Vehicle Fleet Connections
authors: Li, Guo, Sun, Xin, Wang
year: 2014
venue: IEEE Transactions on Power Systems 29(6), 3114-3115 (Power Engineering Letters)
pdf: Anexos/LiGuo.pdf
role: origem da formulacao com EVs correntes e futuros esperados (citado por Zhang)
tags: [paper]
prioridade: 6
status: por-ler
lido_em: 
confirmado: nao
---

# LiGuo

## Resumo

Carta de duas paginas que propoe o N-RT, um carregamento inteligente em tempo real que, alem dos EVs ligados, usa uma previsao dos EVs que se vao ligar no futuro.
Parte do metodo RT de Gan, Topcu e Low, com horizonte deslizante e enchimento de vales (valley-filling).
O objetivo divide-se em dois termos: um para os EVs correntes e outro para a frota futura, cuja taxa total de carga e uma variavel de otimizacao.
Em tres cenarios com dispersao crescente das ligacoes, o N-RT fica sempre mais perto do ideal do que o RT, mesmo com a pior previsao testada.
Trata a frota futura de forma agregada e nao evento a evento.

## Incertezas tratadas

- [[Incerteza: carros eletricos]]

## Temas

- [[MPC para carregamento]]
- [[Previsao de EVs]]

## Associacao com papers anteriores

Proposta inicial minha, por confirmar apos a leitura:

- [[Zhang]]: ref. 18, de onde adapta a formulacao de eventos correntes (CCE) e futuros (FCE). O Zhang passa de frota agregada a eventos individuais
- [[McClone]]: tambem usa EVs previstos dentro do MPC, mas por EV e com custo de fatura
- [[Lee]]: o metodo RT que o LiGuo estende e do Gan, Topcu e Low, grupo do ACN. O ASA e da mesma linhagem de MPC convexo

## Notas e por fazer

Ficheiro vindo do buffer. Li as duas paginas completas.
Confirmar na leitura detalhada as equacoes (1) a (3) do PDF, porque a extracao de texto perdeu as formulas.
Ver o que o Zhang mudou face a esta formulacao ao passar a eventos individuais.

## O que foi retirado

por preencher

## Metodo e dados

Horizonte deslizante com janela suficiente para cobrir a ultima saida dos EVs ligados.
Termo corrente: enchimento de vales com os EVs ativos.
Termo futuro: taxa total da frota futura como variavel, limitada pela potencia maxima prevista com um fator de regulacao, e energia total limitada pela procura prevista mais a capacidade restante (modelo de frota de Bessa e Matos).
Previsoes de potencia maxima, procura e capacidade atualizadas periodicamente a partir de dados historicos.
Tres cenarios (S1 a S3) com dispersao crescente do instante de ligacao e quatro niveis de precisao da previsao (P_A perfeita ate P_D pior).
Dados de simulacao herdados do trabalho RT (Gan et al.), sem dados reais de carregamento.

## Contribuicao para a tese

por preencher

## Limitacoes e criticas

por preencher

## Perguntas em aberto

por preencher

## Citacoes a usar

por preencher

PDF: [[LiGuo.pdf]]
