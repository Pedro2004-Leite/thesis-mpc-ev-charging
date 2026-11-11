---
title: Adaptive Charging Networks: A Framework for Smart Electric Vehicle Charging
authors: Lee, Lee, Lee, Jin, Lee, Low, Chang, Ortega, Low
year: 2021
venue: IEEE Transactions on Smart Grid 12(5), 4339-4350
pdf: Anexos/Lee.pdf
role: sistema ACN e escalonador MPC de referencia (ASA) para a validacao
tags: [paper]
prioridade: 2
status: por-ler
lido_em: 
confirmado: nao
---

# Lee

## Resumo

Descreve a arquitetura e os algoritmos do Adaptive Charging Network (ACN), instalado no Caltech em 2016 e hoje em mais de 100 locais (PowerFlex).
Propoe o Adaptive Scheduling Algorithm (ASA), um MPC baseado em otimizacao convexa, com funcoes de utilidade modulares e atualizacao por eventos.
Trata tres problemas praticos: rede trifasica desequilibrada, bateria nao ideal (rampdown) e sinal piloto quantizado.
Compara o ASA com EDF, LLF e round-robin em dados reais do Caltech, com ACN-Sim.
Melhora o lucro do operador 3.4 vezes face a carregamento nao controlado e supera os baselines em sistemas muito congestionados.
Assume que os utilizadores dao estimativas exatas de partida e energia, e nao trata previsao.

## Incertezas tratadas

- [[Incerteza: carros eletricos]]

## Temas

- [[Simulacao e co-simulacao]]
- [[MPC para carregamento]]
- [[Comportamento e dados de EVs]]

## Associacao com papers anteriores

Proposta inicial minha, por confirmar apos a leitura:

- [[ACN-Sim]]: o Lee descreve o sistema ACN e o ASA, e os modelos de componentes dele sao a base do ACN-Sim. O ASA e um dos escalonadores de referencia do simulador
- [[Zhang]] e [[Engel]]: tambem MPC para EVs, mas o ASA nao tem previsao nem cenarios
- [[McClone]]: previsao por sessao ligada ao MPC, fora do ambito deste paper
- [[Thurner]]: o Lee usa restricoes de corrente por recurso (transformador, disjuntor), nao tensao

## Notas e por fazer

Ficheiro vindo do buffer com o nome Powerflex.pdf. Li so as primeiras paginas para avaliar relevancia.
Confirmar: o que o ASA assume sobre chegadas futuras (nada, parece), e se a funcao de utilidade com PV (termo G(t)) se liga ao MPC com PV da tese.

## O que foi retirado

por preencher

## Metodo e dados

Dados: 10 415 sessoes do Caltech (2018-05-01 a 2018-10-01, 54 EVSEs), 92.78 MWh.
Passo de 5 min, horizonte maximo de 12 h, chamadas ao escalonador a cada evento ou 5 min.
Restricoes de corrente por recurso l: |sum_i A_li r_i e^(j phi_i) + L_l| <= c_l (cone de segunda ordem), com versao afim conservadora.
Utilidades: carregar depressa, custo de energia com carga liquida N(t) = soma r_i + L - G (G e PV), demand charge com proxy, variacao de carga, partilha justa, penalizacao de nao conclusao.
Cinco cenarios (informacao perfeita ou nao, EVSE continuo ou quantizado, bateria ideal ou CCCV com cauda aos 80%).

## Contribuicao para a tese

por preencher

## Limitacoes e criticas

por preencher

## Perguntas em aberto

por preencher

## Citacoes a usar

por preencher

PDF: [[Lee.pdf]]
