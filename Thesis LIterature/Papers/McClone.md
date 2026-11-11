---
title: Hybrid Machine Learning Forecasting for Online MPC of Work Place Electric Vehicle Charging
authors: McClone, Ghosh, Khurram, Washom, Kleissl
year: 2024
venue: IEEE Transactions on Smart Grid 15(2)
pdf: Anexos/McClone.pdf
role: previsao de EVs por ML ligada a MPC (citado por Zhang)
tags: [paper]
prioridade: 5
status: lido
lido_em: 2026-11-11
confirmado: nao
---

# McClone

## Perguntas para a leitura


## Resumo


Citado por [[Zhang]] como exemplo de previsao por ML encaminhada para o MPC.

## Incertezas tratadas

- [[Incerteza: carros eletricos]]

## Temas

- [[MPC para carregamento]]
- [[Previsao de EVs]]
- [[Comportamento e dados de EVs]]

## Associacao com papers anteriores

Proposta inicial minha, por confirmar apos a leitura:

- [[Zhang]]: Zhang cita-o como exemplo de previsao ML que alimenta o MPC
- [[Engel]]: alternativa por cenarios GMM, aqui previsao pontual por ML
- [[Genov]], [[Ran]], [[Cheng]]: tambem previsao de EVs, aqui ligada ao MPC
- [[DiffPLF]]: previsao por difusao, que este paper nao usa
- [[ACN-Sim]]: dados diferentes (UCSD) mas mesmo tipo de problema
- [[Amara]]: tambem preve por sessao, mas so a previsao e nao liga ao MPC

## Notas e por fazer

Aparece nas referencias de Zhang (ref. 21).
Atencao ao baseline de persistencia, que pode servir de baseline da tese.

## O que foi retirado

Permite determinar o tuplo de time of arrival, energy demand e tempo de permanência ao longo do ano. 
A motivação deste paper foca-se em peak demand reduction e dar shift da carga para horas em que a produção solar ou de vento é superior. 
Menciona que powerflex utiliza um algortimo de adaptive load management (ALM). 

Menciona que existe um grande número de previsão do agregado, mas ao nível das sessões torna-se mais difiicil. 

Em charging scheduling existem dois problemas: 1. offilne (Assume conhecimento perfeito do tuplo); 2. Online (Lida com essa incerteza). Este paper foca-se no último. 

Deu boa referência para leitura, que é metodo de MPC utilizado pela Powerflex nesta altura. 

O custo considera-se energia e demand. Utiliza horizonte de 24 horas, com passo de 15 minutoss (standart). Ou seja, o MPC roda em 96 passos num dia. 

![[Pasted image 20261111150506.png|514]]

Nos estados unidos pelo menos, o custo da energia é ordens de magnitude menor que o pico de demand charging. Desta forma, o objetivo do controlador é realmente fazer com que curva de demand fique constante. 

As assumptions consistem que ao chegar o utilizador preenche corretamente o energy demand e o departure time. Para além disso, que a cada 15 minutos todo o plano de carregamento muda e que se um carro chegar as 8:05 h então o EV só começara a carregar as 8: 15h. 
Quando o tempo chega ao tempo de chegada de um determinado EV, então esse EV é removido dos forecasted EVs; 
Como estes modelos pdem ser avaliados? Este paper sugere uma métrica cálculo do erro. 

A baseline utitlizada neste estudo é a persistência, que neste caso diz-nos que os EVs que estão a carregar num determinado momento são os mesmos do dia anterior (observado). Devido às diferenças no workplace entre estes dois, utiliza-se uma persistência para dias da semana, outra para fim de semana e outra para feriados. O forecasting é feito minuto a minuto (smart persistence). 

Utiliza uma pipeline interessante: 
Primeiramente, a agregated daily demand é calculada pelo TreeBagger do Matlab (random forest - bagged decision trees), que são treinados com valores diários de EVs que chegam e a energy demand (diários). O treebagger cria uma relação entre o número de EVs que estão e a energia requesitada, ele recebe o input da persistência smart (para o N de Evs que irão chegar). Depois  uma LSTM pega nessa ADED, juntamente com o número de carros elétricos da persistência inteligente e o calendário para dar a curva acumulada de chegadas por minuto (numero de EVs acumulados até esse minuto). Depois o KNN, vai ao espaço de todos os dias e copia aquele que tem o ANAPM (acumulated number of EV arriavals per minute) e popula para cada EV com o tuplo (tempom de chegada, partida e energia). 

![[Pasted image 20261111150203.png|470]]

O algoritmo é sempre treinado à meia noite o que consome 9 minutos. Arquitetura é simples: 


![[Pasted image 20261111150544.png]]

![[Pasted image 20261111150716.png|416]] 

Os resultados revelam que o MPC com forecasting melhora significativamente os resultados de redução de picos face a um MPC sem forecasting.   
## Metodo e dados
Utiliza um modelo mais complexo para fazer a previsão das chegadas, permanência e energia. 

## Contribuicao para a tese

Levanta o problema de qual métrica se deve utilizar neste tipo de forecasting; 
Fornece um framework para criar modelos mais robustos; 
Permanência inteligente aparece como uma boa alternativa simples; 
Nos estados unidos pelo menos  a Peak demand é um fator muito importante a mitigar. 
Fornece uma arquitetura de ML MPC simples. 

## Limitacoes e criticas

por preencher

## Perguntas em aberto

por preencher

## Citacoes a usar

por preencher

PDF: [[McClone.pdf]]
