---
title: Zhang
authors: Zhang, Rigo-Mariani, Hadjsaid
year: 2025
venue: Energy and AI 21, 100522
pdf: Anexos/Zhang.pdf
role: paper mais proximo da tese
tags:
  - paper
prioridade: 10
status: lido
lido_em: 2026-11-10
confirmado: sim
---

# Zhang

## Resumo

Compara tres estrategias de gestao de frotas de EVs sob incerteza: MPC base, MPC hibrido com dados e DRL.
No MPC hibrido, um modelo de difusao trata a incerteza nos inputs dos utilizadores (hora de partida e energia pedida).
Um GMM modela as chegadas e partidas futuras.
Liga diretamente a previsao de EVs com difusao ao desempenho do MPC, o que corresponde ao cenario a) da tese. 

## Incertezas tratadas

- [[Incerteza: carros eletricos]]

## Temas

- [[MPC para carregamento]]
- [[Modelos de difusao]]
- [[Comportamento e dados de EVs]]

## Associacao com papers anteriores

Confirmado com o autor das notas:

- [[DiffPLF]]: Zhang cita-o (ref. 13). Ambos usam difusao para incerteza de EVs, com alvos diferentes (carga agregada vs inputs dos utilizadores)
- [[Genov]]: nao e citado por Zhang. Ligacao minha pelo GMM e pelo ACN-Data
- [[ACN-Sim]]: Zhang cita o ACN-Data (ref. 16), nao o simulador. O cenario pode ser reproduzido no ACN-Sim
- [[Saleem]]: nao e citado por Zhang. Tambem MPC com EVs por cenarios, mas aqui sem PV nem bateria

Relacao com o esqueleto da formulacao: da a formulacao por evento dos EVs (ver [[Esqueleto da formulacao]]).
O [[Engel]] complementa-o com melhor arquitetura e sistema integrado.

Citados por Zhang, que li no proprio paper:

- [[Engel]]: ref. 20, exemplo de cenarios amostrados de GMMs ajustados a dados reais
- [[McClone]]: ref. 21, previsao de chegadas por ML (TreeBagger, LSTM, kNN) enviada para o MPC
- [[Li]]: ref. 22, DiffCharge, difusao para gerar cenarios de carregamento
- [[Amara]]: ref. 11, benchmark de onde vem a previsao deterministica dos eventos futuros no MPC baseline
- [[LiGuo]]: ref. 18, de onde se adapta a formulacao CCE e FCE (Li, Guo, Sun et al., IEEE Trans. Power Syst., 2014)

## Notas e por fazer

Ler em detalhe: define o desenho experimental a replicar e a estender com PV, edificio, bateria e rede.

- Confirmar qual e o dataset principal. O paper cita o ACN-Data (ref. 16) para o erro tipico do utilizador (eC cerca de 54%) e Palo Alto (ref. 30) para os dados reais, mas a declaracao de disponibilidade diz que os dados sao confidenciais.
- Ver no [[Amara]] qual dos modelos bottom-up pode ser a previsao deterministica do baseline.
- A equacao (9), P_p = P_c x m_cp para todos os p e c, esta mal escrita. A leitura correta e P_p = soma sobre c de m_cp x P_c.
- Ver o [[Engel]] e o [[Amara]] para o treino do GMM, que o Zhang nao descreve.

## O que foi retirado

Do ponto de vista operacional um dos maiores desafios é a impossibilidade de previsão o número de futuros EVs aos pontos de carga, tempo de partiga e energia requisitada. 

Um dos efeitos que de forma comum não é tratado é a forma como a incerteza sobre o input dos utilizadores não é considerado. 

Diz que uma das técnicas mais utilizadas para EV charging é MPC, em que o objetivo é através do conhecimento futuro sobre as chegadas, ele decide quanta energia está disponível nos ports de carregamento. 

Existe a distinção entre eventos correntes - carros que estão agora conectados e futuros - aqueles que se vão conectar. 
Trabalhos relacionados: 

Os future charging events podem ser representados por cenários sampled de um Gaussian Mixture Model, que é fitted a dados reais [[Engel]] e passado ao MPC. 

Machine learning tmb é uma solução, [[McClone]] , apresenta um algoritmo que usa KNN com LSTM para prever chegadas e mandar para um MPC. [[Li]] utilizou denoising diffusion models para fazer forecasting de charging events e depois integraram os resultados em MPC. 

[TODOS ESTES PAPERS SERÃO LIDOS, PARECEM MUITO INTERESSANTES] 

Este trabalho dá neglect de future charging events. Sendo que o seu principal foco é em tratar a incerteza dos utilizadores. 

MPC sofre de problemas relacionados à formulação do problema de otimização, problemas de convexidade, linearidade. Métodos baseados em DRL, dependem do facto do estado ter um tamanho fixo o que não é bom porque o número de charging events varia. 

Demonstram que o approach hibrido tem sucesso, entregando cerca de 95% da carga e reduzindo em 20% o pico de demanda. 

Arquitetura do problema: 

minimizar o pico de energia agregada durante um dia. 

As sessões são divididas em futuras e correntes. O controlador pega na informação sobre as incertezas das correntes e a previsão das futuras  para calcular o control. 

As correntes e as futuras cada uma é definida por conjuntos de tuplos, constituidos pelo tempo de chegada, o tempo de partida e a energia requisitada. O número de conjunto de tuplos é caracterizado pelo número de sessões, que no caso corrente é conhecido, mas no caso futuro é incerto. 

No caso do corrente, só a energia e o tempo de partida são sujeitos a incerteza, uma vez que o tempo de chegada é conhecido. 

![[Pasted image 20261110125933.png]]

No caso futuro todos os parâmetros são incertos, dado que o tempo de chegada é desconhecido. 

Os controlos são enviados como setpoints para os carregadores. 

Arquitetura: ![[Pasted image 20261110125957.png]]

Relativamente à estratégia de controlo, é utilizado um skrinking horizon, desde o current time até ao final do dia. A resolução é 15 minutos. É minimizado o peak power agregado. 

Para o current charging events e future são definidas restrições de potência de carregamento e de energia requisitada. 
No MPC standart base, é utilizada para eventos futuros o resultado de um laboratório francês, que utiliza um predictor deterministico. 

Uma das contribuições deste artigo é substituir isso por um GMM para a future uncertainty. 

![[Pasted image 20261110135533.png]]

Dão fit a 3 distribuições, uma para o número de eventos, outra para o tempo de chegada e uma joint para a energia da sessão e do tempo de partida.  Este último é porque estão muito correlacionados. Cada distribuição é um elemento. O número de componentes é 4 para q(N_F), 4 para q(T_f^arr) e 2 para q(E_f, T_f^dur).

A forma como se gerem os cenários é muito simples, para cada cenário dá-se sample do número de eventos. Para cada evento dá-se sample do tempo de chegada e da energia à chegada e tempo de carregamento, sendo que o tempo de partida calcula-se simplesmente somando à chegada o tempo de carregamento. 
Só se escolhem as chegadas que são postiores ao tempo em que está a correr o MPC. 

![[Pasted image 20261110152210.png]]


Neste paper são gerados 10 cenários. 
A diferença do MPC hibrido para o baseline foi que este passa o input do utilizador através da diffusion layer, para obter o tempo de partida e energia menos incertos. Depois com cada um do cenários gerados F, essencialmente um MPC roda, depois fazendo merge com uma média dos resultados de cada um. 
![[Pasted image 20261110153337.png]]


O full data driven approach é apresentado com um POMPDP (partially observable Markov decision problem), o qual não é muito do nosso interesse. 

A baseline utilizada para comparar as diferentes alternativas, foi com uma politica em que simplesmente quando o carro chega o carregador executa potência constante até ele sair. 
Também são comparados com um oráculo. 

## Metodo e dados

O objetivo aqui definido é entregar o máximo de energia possível ao mesmo tempo reduzir o pico de energia da estação. Estes são medidos relativamente à energia diária entregue e relativamente ao pico de energia registado, em kWh e kW. Para além disso é utilizada uma métrica que mete a diferença destas duas quantidades relativamente às obtidas pelo oráculo. 

São utilizados 52 carregadores elétricos. COm um valor máximo para todos os EVs e 7.7 kW. 
A implementação do MPC foi baseada em Pyomo e Gurobi. 
Pyomo: permite construir em Python de forma simples o problema de otimização antes de o entregar a um solver. 
Gurobi: solver comercial, tentar compreender se professor tem acesso através do técnico a este tipo de solvers. 

Mencionam as especificações do computador. 

""hybrid MPC, it can reduce the peak charging power by 20.2 % ~ 23.8 % compared with the uncontrolled charging while delivering 94.6 % ~ 95.8 % energy to EV, which is much higher than the baseline MPC. This is due to the mitigation of the user uncertainty by the diffusion model and the mitigation of the future uncertainty by scenario generations from GMMs rather than a single forecast, which also boosts the performance of data hybrid MPC

Mencionam que tempo de correr os 10 cenários é bem menor que 900s (15 minutos). 


- A matriz de conexao M liga cada CCE a uma porta. E um parametro conhecido em cada passo, por isso o problema continua linear.

- Os FCEs nao passam por M, porque ainda nao tem porta. Entram diretamente na soma do pico, equacao (10).

- Cada FCE tem as suas variaveis de potencia, com restricoes de janela de chegada e partida e de energia total.

- O baseline usa uma previsao deterministica dos FCEs tirada do benchmark do [[Amara]], ref. 11.
- A difusao e um MLP com uma camada escondida de 16 neuronios, K = 25 passos, treinada de 01/01/2019 a 30/06/2019 e testada em outubro de 2019.
- O input do utilizador e simulado como gaussiano em torno do valor real, com desvios sigma_T e sigma_E, e a metrica eC mede o erro.
- Impacto de cada incerteza no baseline, tabela 3: so incerteza futura aumenta o pico em cerca de 21% sem reduzir a energia. So incerteza do utilizador reduz a energia entregue entre 17% e 26% e quase nao mexe no pico.

## Contribuicao para a tese

Permite compreender como é que poderia ser estruturado o MPC no contexto do projeto, pelo menos para a parte dos carregadores. Permite compreender como se faz MPC hibrido, com cenários. 

Permite compreender que a tipologia da rede é importante de ser integrada, a forma como os barramentos estão feitos. Sugere que GMM são bons para lidar sobre a incerteza de arrivals futuras. 

Dá set do paradigma de user input como elemento crucial. 

Pontos concretos para a tese:

- O Zhang so trata EVs. Para a tese, o previsor de chegadas futuras (o papel do GMM) pode ser trocado por difusao e comparado com o GMM como baseline.
- O mesmo desenho por CCE e FCE serve para separar o que o previsor tem de prever (so os FCEs) do que vem do utilizador (os CCEs).
- A matriz M passa a ter efeito quando houver restricoes de rede, porque as portas estao ligadas a fases e barramentos especificos. Ai serve para somar as potencias das portas por barramento.
- Mostra que o ganho do MPC hibrido nao e separavel entre difusao e GMM. A tese pode desenhar uma ablacao que isole o efeito do previsor no pico e na energia.

## Limitacoes e criticas

Não existe info sobre o treino do GMM

- Nao diz o algoritmo de ajuste, o periodo de dados, nem como escolheu 4, 4 e 2 componentes.
- Nao explica como um GMM modela uma contagem (N_F).
- Os dados sao confidenciais, por isso a experiencia nao e reproduzivel.

- O erro do utilizador e sintetico, gaussiano. O proprio paper admite esta limitacao.
- A media dos controlos de N_S MPCs nao garante que o resultado seja admissivel para todos os cenarios, e nao e um MPC estocastico com um problema unico.
- So trata EVs e minimiza so o pico, sem PV, bateria, edificio nem rede.
- O baseline usa uma previsao que o paper nao descreve, apenas cita o benchmark.

## Perguntas em aberto

- Quanto do ganho do MPC hibrido vem da difusao e quanto vem do GMM?
- Que modelo do [[Amara]] e a previsao deterministica do baseline, e como e convertida em tuplos de chegada, partida e energia?
- *"Como se treina o GMM do Zhang, e que dados usa?* 

- Como entram as restricoes de rede, e como se usa M para agregar por barramento ou fase?
- Vale a pena media de controlos por cenario, ou um MPC estocastico com um problema unico?

## Citacoes a usar

- "We adopt results of the deterministic forecast from the EDF Lab France [11] for FCEs." (secao 3.2, p. 5)
- "From the results, the user uncertainty has a higher impact on the controller." (secao 4.2, p. 10)
- "This is due to the mitigation of the user uncertainty by the diffusion model and the mitigation of the future uncertainty by scenario generations from GMMs rather than a single forecast." (secao 4.4, p. 10)
- "The data that has been used is confidential." (declaracao de disponibilidade de dados, p. 14)



PDF: [[Zhang.pdf]]
