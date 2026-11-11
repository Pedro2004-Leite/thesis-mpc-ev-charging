---
title: pandapower - an Open Source Python Tool for Convenient Modeling, Analysis and Optimization of Electric Power Systems
authors: Thurner, Scheidler, Schaefer, Menke, Dollichon, Meier, Meinecke, Braun
year: 2018
venue: IEEE Transactions on Power Systems 33(6), 6510-6521
pdf: Anexos/Thurner.pdf
role: ferramenta de rede para a co-simulacao e para as restricoes de rede
tags: [paper]
prioridade: 12
status: por-ler
lido_em: 
confirmado: nao
---

# Thurner

## Resumo

Apresenta o pandapower, uma ferramenta em Python com licenca BSD para analise estatica e quase estatica e otimizacao de redes eletricas equilibradas.
Tem fluxo de potencia (Newton-Raphson, com opcao de backward e forward sweep), fluxo de potencia otimo AC e DC, estimacao de estado, curto-circuito segundo a IEC 60909 e pesquisas topologicas.
As redes definem-se com elementos como barramentos, linhas, transformadores, cargas e geradores estaticos, com os dados em tabelas pandas.
Os modelos dos elementos foram validados contra software industrial.
O estudo de caso e uma simulacao quase estatica de series temporais numa rede de 10 kV.

## Incertezas tratadas

Nenhuma. E uma ferramenta de simulacao de rede.

## Temas

- [[Restricoes de tensao e rede]]
- [[Simulacao e co-simulacao]]

## Associacao com papers anteriores

Proposta minha, por confirmar apos a leitura:

- [[ACN-Sim]]: os case studies do ACN-Sim usam OpenDSS, e este e o alternativo em Python para a rede em malha fechada. Ver o guia de integracao
- [[Saleem]]: valida a tensao com Simscape e OPAL-RT, aqui a rede simula-se em Python
- [[Grob]]: limite de injecao na rede para evitar violacoes de tensao

## Notas e por fazer

Uso no relatorio: secao 3, para justificar a ferramenta da rede.
O paper diz que o pandapower trata redes trifasicas equilibradas (simetricas). Confirmar se chega para o modelo trifasico do guia de integracao, porque redes desequilibradas pedem outras ferramentas, como o OpenDSS.
O fluxo de potencia otimo permite restricoes de tensao nos barramentos e de carga nas linhas e nos transformadores.
Pode reutilizar a matriz de admitancias entre fluxos de potencia que so mudam nas injecoes, o que acelera series temporais.
O paper nao fala de sensibilidades do fluxo de potencia, que o plano preve usar no MPC (Fase 5).
Ler a parte do fluxo de potencia, do fluxo otimo e o estudo de caso de series temporais.

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

PDF: [[Thurner.pdf]]
