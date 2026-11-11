---
title: Saleem
authors: Saleem, Saha, Izhar, Ang
year: 2024
venue: Energy and Buildings 325, 114993
pdf: Anexos/Saleem.pdf
role: referencia de MPC estocastico e tensao, so controla a bateria
tags: [paper]
prioridade: 16
status: por-ler
lido_em: 
confirmado: nao
---

# Saleem

## Perguntas para a leitura

Responder durante a leitura e passar as respostas para as seccoes abaixo.

1. Que tipo de problema resolve (LP, QP, NLP, nao convexo) e porque usa GlobalSearch em vez de um solver convexo? 
2. Qual e a funcao de custo esperado e que termos tem (energia, tarifa de injecao, degradacao)?
3. Quais sao as variaveis de decisao e o que fica de fora? Os EVs sao controlados ou so entram como procura?
4. Como se geram os cenarios de PV, carga e EVs, quantos sao e como se reduzem?
5. A incerteza entra por custo esperado ou por restricoes probabilisticas? Os cenarios partilham as mesmas decisoes?
6. Qual e o horizonte e o passo, e porque otimiza de hora a hora?
7. Como modela a procura dos EVs (mobilidade e SoC esperado) e serve para um local de trabalho?
8. Como valida (Simscape, OPAL-RT) e com que metricas? Serve de referencia para a minha validacao em malha fechada?
9. O que se aproveita para a tese e o que se descarta?

## Resumo

MPC estocastico baseado em cenarios para PV, bateria e carregamento de EVs em complexos residenciais.
Cenarios para carga, procura de EVs e geracao solar.
A bateria fornece potencia reativa para estabilidade de tensao.
Validado em Simscape Electrical e em tempo real num OPAL-RT.

## Incertezas tratadas

- [[Incerteza: paineis solares]]
- [[Incerteza: edificio]]
- [[Incerteza: carros eletricos]]

## Temas

- [[MPC estocastico]]
- [[Sistemas integrados PV+bateria+EV]]
- [[Restricoes de tensao e rede]]

## Associacao com papers anteriores

Relacao com o esqueleto da formulacao: referencia de MPC estocastico e de tensao, sem controlo dos EVs (ver [[Esqueleto da formulacao]]).

Proposta inicial minha, por confirmar apos a leitura:

- [[Torres]]: mesmo tipo de sistema integrado, com MPC nao estocastico
- [[Loparo]]: MPC com PV, bateria e edificio
- [[Brown]]: MPC estocastico com previsao PV probabilistica
- [[Grob]]: MPC estocastico com previsao PV probabilistica
- [[Zhang]]: incerteza de EVs no MPC por cenarios, sem PV nem bateria. Nao se citam um ao outro

## O que foi retirado

Este paper dá um framework para integração de todas as fontes de incerteza num MPC estocástico. De forma diferente de Zhang, que fez MPC por cenários e fazia média depois dos MPCs ou de Engel que gerava cenários e retirava a média dos mesmos. 

Prediction horizon de 24 horas, 
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

PDF: [[Saleem.pdf]]
