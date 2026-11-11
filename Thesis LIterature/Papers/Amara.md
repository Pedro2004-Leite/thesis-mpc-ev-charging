---
title: A Benchmark of Electric Vehicle Load and Occupancy Models for Day-Ahead Forecasting on Open Charging Session Data
authors: Amara-Ouali, Goude, Hamrouche, Bishara
year: 2022
venue: ACM e-Energy 2022 (Twelfth International Conference on Future Energy Systems)
pdf: Anexos/Amara.pdf
role: benchmark de previsao de sessoes de EVs, base do previsor (citado por Zhang)
tags: [paper]
prioridade: 4
status: lido
lido_em: 2026-11-10
confirmado: sim
---

# Amara

## Perguntas para a leitura

Responder durante a leitura e passar as respostas para as seccoes abaixo.

1. Como e definido o vetor de uma sessao e como se reconstroi a carga a partir das sessoes?
2. Como se preve o numero de sessoes por dia (GRU, SARIMA, NHPP) e qual funciona melhor?
3. Como se ajusta o modelo de misturas (algoritmo, tipo de covariancia, normal ou lognormal) e como se escolhe o numero de componentes?
4. Como se condiciona a duracao e a energia a hora de chegada?
5. Que pre-processamento e feito (filtros de duracao e energia, dias uteis, limiar de chegadas)?
6. Como se treina e avalia (janela deslizante, reestimacao, metricas)?
7. Como se comportam os modelos bottom-up no Caltech (ACN) face aos diretos?
8. O que falta para implementar o meu GMM (biblioteca, inicializacao, amostragem em vez de esperanca condicional)?
9. O que se aproveita para o previsor da tese?

## Resumo

Benchmark de 14 modelos para previsao day-ahead de carga e ocupacao de EVs, em 8 datasets abertos (residencial, local de trabalho e publico).
Compara duas abordagens: direta (preve a carga ou ocupacao agregada) e bottom-up (modela cada sessao e agrega).
Na abordagem bottom-up, cada sessao e o triplo chegada, duracao de carregamento e energia, que e exatamente o que o previsor da tese precisa.
Os modelos bottom-up preveem o numero de sessoes por dia (GRU ou SARIMA) e amostram o triplo de um modelo de misturas (GRU-MM e SARIMA-MM), ou simulam chegadas por um processo de Poisson nao homogeneo (NHPP-GAM-MR e NHPP-RF-MR).
Conclui que a abordagem direta tem melhor desempenho em geral, mas que a bottom-up contribui para a agregacao adaptativa proposta.
Previsao pontual, e deixa a previsao probabilistica como trabalho futuro.
[[Zhang]] cita-o (ref. 11) como fonte da previsao deterministica de eventos futuros usada no MPC baseline.

## Incertezas tratadas

- [[Incerteza: carros eletricos]]

## Temas

- [[Previsao de EVs]]
- [[Comportamento e dados de EVs]]
- [[Previsao probabilistica]]

## Associacao com papers anteriores

Relacao com o esqueleto da formulacao: base do previsor por sessao (ver [[Esqueleto da formulacao]]).

Confirmado depois da leitura:

- [[Zhang]]: cita o Amara (ref. 11) como fonte da previsao deterministica do baseline. A estrutura numero de eventos mais misturas e parecida com a do GMM dele, mas a dele e factorizada e com K fixo
- [[Engel]]: GMM para chegada, permanencia e energia, da mesma familia. O Amara escolhe K por BIC e usa uma mistura conjunta
- [[Genov]]: tambem compara GMM e arvores no ACN-Data, mas so energia e duracao, e aqui entra tambem a chegada
- [[McClone]]: previsao por sessao com ML ligada ao MPC, e o Amara fica so na previsao
- [[Ran]] e [[Cheng]]: previsao da carga total, que corresponde a abordagem direta daqui
- [[ACN-Sim]]: o Caltech, do ACN-Data, e um dos 8 datasets

## Notas e por fazer

Aparece nas referencias de Zhang (ref. 11).
Confirmar qual dos modelos bottom-up Zhang usou como previsao deterministica dos eventos futuros.
Ver o que o benchmark diz sobre quantos dados sao precisos para o modelo de misturas.

Por ver, guardado para o futuro (analise de 2026-11-10, o essencial para a tese ja foi retirado):

- Consultar so quando for implementar o previsor com os dados do ACN:
  - como a contagem diaria e modelada em detalhe (covariaveis do SARIMA e tratamento dos fins de semana, que o paper exclui);
  - se alguma figura isola o Caltech, que e o dataset do ACN, porque o paper so da a media dos 8 datasets e o caso do Domestics UK (Tabela 4);
  - detalhes dos dados no apendice (Tabelas 1 e 5): numero de sessoes do Caltech e variaveis registadas.
- Para testar nos nossos dados, porque o paper nao os resolve:
  - inicializacao do EM, tipo de covariancia e uso de normal ou lognormal;
  - atrasos na contagem diaria e frequencia de retreino, como fatores da ablacao em [[Hipotese]].
- Agregacao de especialistas (AGG): nao e relevante para gerar sessoes, porque combina previsoes agregadas. Fica como opcional se mais tarde se quiser testar.

## O que foi retirado

Introduz vários open datasets de carregamento, em que o SAP é de workplace e pode torna-se útil para o nosso contexto em específico. 

![[Pasted image 20261110200005.png|330]]
Para o procedimento de treino, utilizou-se um framework de rolling-origin, a.k.a o modelo é reestimado a cada duas semanas. 

Duas técnicas foram aqui exploradas: 1. Técnica eleita como a mais preferencial, fazer forcasting do número de sessões de carregamento e depois retirar os target vector de uma multivariate distribution (Gated recurrent units (GRU) + GMM) ou (SARIMA + GMM); 

2. Simular as chegadas através de um NHPP (processo de poisson não homogeneo) e depois fazer o forcasting do valor esperado dos target vectors condicionado nas chegadas simuladas. 

Um mixture model é essencialmente a soma de várias densidades de probabilidade com pesos, tudo obtido através de Expected-Maximisation. 

O hiperparâmetro deste modelo é o valor K. 

Modela de forma conjunta sobre tempo de chegada, permanência e energia, diferente face à fatorizada de Zhang. 

Escolhe o K dessa GMM através do BIC (Bayesian information Criterion), isto dá-nos uma forma simples de treinar a GMM: treina-se para vários valores de K, guarda-se o com menor BIC. 
O Zhang utilizou valores fixos. 

De forma diferente do Zhang, utiliza GRU ou Sarima saber o número do dia (número de  eventos). O zhang modela unicamente com uma GMM. 

Relativamente ao processamento de dados, descartaram-se as horas com poucas chegadas, com limiar de 7.5%.  Só se trabalhou com dias uteis. 

Ao tomarem os clusters só com mais de 5% do peso, ficaram 3 clusters que juntos contabilizam mais de 50% do peso. 

![[Pasted image 20261110193734.png|469]] 

É possível analisar que o cluster 14, correspode ao cluster dos madrugadores, enquanto que os clusters 6 e 11, correspodem a chegadas mais para o período da tarde, mas com diferentes energias. 

É utilizada uma gridsearch para selecionar o melhor conjunto de hiperparametros para cada modelo, com split 80-20. 

Menciona que bottom-up approach é: "key to the effective implementation of smart charging strategies". 

O paper também propoe um mecanismo de error correction através de um SARIMA, mas que para o nosso caso não é relevante só útil para up-bottom approach (agregado). 

A métrica utilizada é o RMSE. Outra métrica utilizada é o PIP (Percentage improvement from persistance). 
## Metodo e dados

![[Pasted image 20261110201840.png|461]] 

O SARIMA-MM é o melhor bottom-up

Os dados sao sessoes de carregamento de 8 sitios abertos. Cada sessao tem a hora de chegada, a duracao e a energia.
Antes de treinar, tiram-se as sessoes estranhas: duracao negativa ou maior que 24 horas, e energia negativa ou maior que 100 kWh.
Os modelos sao treinados de novo de 2 em 2 semanas e testados em 8 semanas.
Nos modelos de misturas, o numero de componentes K escolhe-se de 2 a 30 e fica o que tem menor BIC.
A medida de comparacao e o PIP. Diz quanto o modelo melhora face a persistencia, e quanto maior, melhor.

## Contribuicao para a tese

Da uma receita simples para gerar as sessoes futuras: primeiro preve-se quantas sessoes vao haver no dia, e depois sorteia-se a chegada, a duracao e a energia de cada uma a partir de uma mistura.
Mostra como escolher o numero de componentes sem ser a olho: treina-se com varios K e fica o de menor BIC.
Serve de base ao GMM mais forte da hipotese, para comparar com o do Zhang e com a difusao.
Diz qual dos modelos por sessao funciona melhor, que e o SARIMA com mistura.
Da a limpeza dos dados que posso aplicar ao ACN


## Limitacoes e criticas

So da um valor previsto, e para os cenarios do MPC preciso de amostras.
Mede o erro na carga total e nao a qualidade das sessoes geradas, nem o efeito no controlo.
Nao compara a mistura conjunta com a mistura separada do Zhang.
Na carga total, o bottom-up e fraco: o SARIMA-MM melhora so cerca de 10% face a persistencia, contra cerca de 28% do GAM direto.
Nao diz como arranca o EM, o tipo de covariancia, nem se usa normal ou lognormal.
O NHPP com mixture regression correu mal, e os autores so suspeitam do motivo.
Preve um dia de cada vez e nao usa as chegadas que ja aconteceram hoje.
O PIP engana: um valor acima de 100 nao e um erro enorme, e uma melhoria grande.


## Perguntas em aberto

A mistura conjunta gera sessoes mais realistas do que a do Zhang?
Que K sai nos dados do ACN?
Como se sorteiam sessoes da mistura conjunta para fazer cenarios?
Vale a pena atualizar o previsor com as chegadas que ja aconteceram hoje?
Retreinar com mais frequencia ajuda?


## Citacoes a usar

 "we have only kept charging sessions which respect the following criteria: the charge duration has to be positive and shorter than 24 hours (if the charge duration is not available then the park duration is used instead); energy demand also needs to be positive and under 100 kWh. Charging sessions lasting for more than a day are likely to be data collection errors as an EV is usually charged in a few hours. As for the 100 kWh upper bound, it corresponds to the battery capacity of the Tesla Model S which is the largest amongst top selling EVs" 

30 components might seem a lot for a mixture model but we’ve found that for most datasets the optimal number of components is between 20 and 30.

PDF: [[Amara.pdf]]

NHPP methods do not perform well…
