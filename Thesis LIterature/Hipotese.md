---
tags: [hypothesis]
---

# Hipotese: valor da previsao para o controlo

Hipoteses do projeto, da mais geral para as mais especificas.
A principal (H1) pergunta se uma previsao boa de EVs, PV, edificio e bateria da uma boa politica de controlo.
A hipotese da difusao (H2) passa a ser uma das formas de melhorar a previsao dentro de H1.
As hipoteses secundaria, terciaria e quaternaria, mais abaixo, sao ablacoes ou fatores dentro de H1 e H2.

## Hipotese principal (H1): previsao boa, controlo bom

Um MPC alimentado por previsores de EVs, PV, edificio e bateria aproxima-se do desempenho do oraculo, para varios perfis de operador, e a distancia ao oraculo diminui quando a qualidade do previsor aumenta.
O oraculo e o mesmo MPC com previsao perfeita.
Nao se afirma que o MPC e otimo, porque com previsao imperfeita nunca o e. Afirma-se que fica perto do oraculo e que a previsao explica a distancia que resta.

### Perfis de operador

Cada perfil e uma combinacao de objetivos, para dar opcoes a empresas diferentes.
Comeca-se por tres, e o quarto e opcional.

| Perfil | Minimiza ou garante | Metricas |
|---|---|---|
| Custo | Custo da energia, comprada menos vendida, com a energia dos EVs entregue | Custo, energia entregue |
| Pico e rede | Pico no ponto de ligacao e violacoes de tensao e de corrente | Pico, violacoes de tensao e de corrente |
| Utilizadores | Energia entregue a cada EV, com custo moderado | Energia entregue, satisfacao por EV |
| Bateria (opcional) | Degradacao da bateria estacionaria e dos EVs | Degradacao |

Para dar opcoes, varia-se o peso de cada objetivo e mostra-se a fronteira de Pareto, ou comparam-se os perfis fixos.
A bateria e o autoconsumo de PV ficam como metricas secundarias em todos os perfis.

### Como medir

- Distancia ao oraculo, como a fracao do ganho do oraculo que o previsor consegue captar: (J sem controlo menos J do previsor) a dividir por (J sem controlo menos J do oraculo). Proposta de definicao, a rever.
- Qualidade do previsor ao nivel do previsor (CRPS, pinball loss, erro pontual) e ao nivel do controlo, medidas as duas, para ver se andam juntas.
- Previsores a comparar: perfeito, persistencia, GMM, LightGBM, regressao quantilica e difusao.
- Tornar perfeita uma incerteza de cada vez (PV, edificio, EVs) para saber qual pesa mais.

### O que pode falsificar H1

- A fracao do ganho captada ser baixa para todos os previsores realistas, o que diria que a previsao nao e o gargalo.
- A qualidade do previsor nao acompanhar o resultado no controlo, porque uma previsao com menor erro nao da necessariamente melhores decisoes.
- Os perfis darem conclusoes opostas, de modo que nao exista um previsor melhor para todos.

### Papers de base

- [[Zhang]]: objetivo de pico e energia entregue, com previsao de EVs.
- [[Engel]]: custo, conforto e degradacao, com pesos escolhidos por Pareto.
- [[Saleem]]: custo e degradacao, com tres incertezas.
- [[McClone]]: custo e pico, com previsao por EV.
- [[Mesbah]]: enquadramento do MPC estocastico.

## Hipotese (H2): a difusao melhora a previsao e o controlo

Um modelo de difusao condicional generativo, que amostra o tuplo conjunto (partida, duracao e energia) de cada sessao futura dada a chegada, da previsoes probabilisticas mais precisas e melhor calibradas do que GMM, LightGBM e regressao quantilica.
Aqui a difusao parte de ruido e gera cenarios por amostragem. Nao e a correcao do input do utilizador, que e a hipotese H5.
Cenario a): a previsao alimenta o MPC, e a qualidade do previsor e medida pelo seu efeito no controlo (custo, violacoes de tensao, energia entregue).
Era a hipotese principal e passou a H2, um caso particular de H1.

### Papers de base

- [[DiffPLF]]: difusao condicional para previsao probabilistica da carga de EVs, com condicionamento por cross-attention.
- [[Li]]: DiffCharge, difusao generativa de cenarios de carga de EVs no ACN-Data, com atencao.
- [[Genov]]: baselines GMM e LightGBM.

O [[Zhang]] nao e base do gerador. A difusao dele mapeia o input do utilizador para uma estimativa dos valores reais, de forma determinista, so para os EVs ja ligados, e nao gera cenarios. Os cenarios do Zhang vem de um GMM. Ver H5.

### Paper por adicionar

Jeste e Kamaci (Fraunhofer ISE), difusao condicional com denoiser Transformer para previsao probabilistica de sessoes de EVs.
Referido no `hypothesis.tex`, mas o paper ainda nao esta disponivel.
Enquanto isso, o previsor de difusao implementa-se a partir de [[DiffPLF]] e [[Li]], e revisita-se quando o paper sair.

## Hipotese secundaria (H3): baseline GMM mais forte

Hipotese de trabalho, ainda nao validada, nascida da leitura de [[Zhang]], [[Engel]] e [[Amara]].
Um gerador de cenarios de EVs por mistura conjunta sobre chegada, duracao e energia, com numero de componentes escolhido por BIC e contagem diaria por SARIMA, produz cenarios mais realistas do que o GMM do [[Zhang]].

O GMM do Zhang:

- Ajusta duas misturas separadas, uma para a chegada e outra para o par energia e duracao, e amostra-as de forma independente.
- Modela o numero de eventos futuros com um GMM.
- Fixa 4, 4 e 2 componentes sem justificar.

### Os fatores a separar

| Fator | Zhang | Variante |
|---|---|---|
| Estrutura | Chegada independente do par energia e duracao | Mistura conjunta sobre chegada, duracao e energia |
| Numero de componentes | 4, 4 e 2 fixos | Escolhido por BIC, testando K de 2 a 30 |
| Contagem de sessoes por dia | GMM para o numero de eventos | SARIMA, que no Amara foi melhor do que o GRU |
| Atrasos na contagem | Nao usa | Numero de sessoes dos dias anteriores como preditores, como o Amara |
| Frequencia de retreino | Nao descrita | Retreino periodico, de 2 em 2 semanas no Amara, contra mais frequente |

A estrutura conjunta e a diferenca de modelo.
A escolha de K, a contagem, os atrasos e o retreino sao diferencas de procedimento.
A mistura condicional a chegada (mixture regression) nao entra na hipotese, porque so e necessaria quando a chegada vem de outro modelo, e os autores do Amara suspeitam que prejudicou os modelos NHPP.

### Fundamento no Amara

- Ajuste por EM e escolha de K por BIC, testando K de 2 a 30, com K otimo tipicamente entre 20 e 30.
- Os modelos de misturas foram os melhores entre os bottom-up.
- A contagem diaria por serie temporal, seguida de amostragem da mistura, foi a melhor estrategia bottom-up, e o SARIMA-MM foi melhor do que o GRU-MM, na carga e na ocupacao.
- Os modelos GRU usam o dia da semana e os atrasos LAG1 a LAG5 da contagem como preditores.
- Reestima os modelos de 2 em 2 semanas, como compromisso entre precisao e custo computacional.
- Refere tendencias fortes e nao estacionariedade nos dados, por exemplo com a adocao crescente de EVs, o que motiva retreinar.

### O que o Amara nao prova

- Nao compara a mistura conjunta com uma factorizada.
- Nao isola o efeito de K, da contagem, dos atrasos nem do retreino.
- Nao testa retreinar com mais frequencia do que de 2 em 2 semanas.
- Avalia o erro da carga ou ocupacao agregada, nao a qualidade dos cenarios nem o efeito no controlo.
- Pode acontecer que a dependencia entre chegada e duracao seja fraca nos dados, e a estrutura conjunta pese pouco.

### Como testar, como ablacao com o mesmo MPC

Variar um fator de cada vez e depois todos juntos:

1. Base: GMM factorizado, como o do Zhang.
2. So a estrutura: mistura conjunta com K pequeno.
3. So o K: modelo factorizado com K escolhido por BIC.
4. So a contagem: base com contagem por SARIMA.
5. So os atrasos: contagem com e sem o numero de sessoes dos dias anteriores.
6. So o retreino: retreino diario contra de 2 em 2 semanas, com janela deslizante.
7. Tudo junto: mistura conjunta, K por BIC, contagem por SARIMA com atrasos e retreino periodico.
8. Previsor de difusao, que e a hipotese principal.

Medir o pico e a energia entregue, como no Zhang, e comparar tambem a qualidade dos cenarios gerados.

### Detalhes a testar nos nossos dados

O Amara nao os resolve:

- Inicializacao do EM, tipo de covariancia, e normal ou lognormal.
- Como amostrar da mistura conjunta para gerar cenarios, em vez de usar a esperanca condicional.
- Atualizacao intradiaria com as chegadas ja observadas no dia, que o Amara nao faz porque e day-ahead.

## Hipotese terciaria (H4): MPC monolitico contra hierarquico

Hipotese de trabalho, ainda nao validada, nascida da leitura de [[Engel]], [[Zhang]] e [[Torres]].
Ao tamanho de um local do ACN (dezenas de portas) e com restricoes de rede por barramento, um MPC monolitico, com uma variavel de potencia por EV, entrega a mesma energia com menor custo e pico do que um MPC hierarquico (agregador e distribuidor), com tempo de resolucao aceitavel.
A hierarquia so compensa acima de um certo numero de carregadores, ou quando o tempo por passo deixa de caber no passo de controlo.

Fundamento:

- O [[Zhang]] resolve um MPC monolitico com 52 portas e 10 cenarios em cerca de 11 s por passo, contra 900 s disponiveis.
- O agregador do [[Engel]] e miope aos EVs individuais e precisa do retorno do distribuidor para corrigir o plano.
- Um problema centralizado com variaveis por EV ve tudo ao mesmo tempo, por isso e, em principio, pelo menos tao bom.
- As restricoes de rede sao por barramento ou fase e precisam da identidade de cada carga. Num agregador, so a camada do distribuidor as pode ver.

O que os papers nao provam:

- O Engel compara o seu distribuidor com um distribuidor simples e nao preditivo, nunca com um MPC monolitico.
- A vantagem que o Engel declara e a escalabilidade e a separacao de responsabilidades, e nao o desempenho.
- Nenhum paper do vault compara os dois desenhos nos mesmos dados.
- Pode acontecer que a hierarquia seja melhor para muitos carregadores, ou para horizontes longos.

### Como testar

Mesmo previsor, mesmos dados e mesmo MPC, variando o desenho:

1. Monolitico, com uma variavel por EV ligado e as sessoes futuras como no [[Zhang]].
2. Hierarquico, como o [[Engel]], com retorno do distribuidor ao agregador.
3. Hierarquico sem o retorno, para ver o efeito dessa correcao.

Varrer o numero de carregadores (por exemplo 10, 25, 50 e 100) e ligar ou desligar as restricoes de rede.
Medir custo, pico, energia entregue, satisfacao por EV, violacoes de rede e tempo por passo.
O resultado esperado e um ponto de cruzamento: monolitico melhor abaixo de certa escala, hierarquico acima.

## Hipotese quaternaria (H5): vale a pena pedir o input ao utilizador

Hipotese de trabalho, ainda nao validada, nascida da leitura de [[Engel]], [[Zhang]], [[Genov]] e [[McClone]].
O input declarado pelo utilizador (partida estimada e energia pedida) so ajuda o MPC se o seu erro for pequeno.
Acima de certo erro, um previsor treinado no historico da melhores resultados, e a melhor opcao e combinar os dois, corrigindo o input com um modelo, como faz o [[Zhang]] com a difusao.

[a testar com erros reais dos utilizadores, ao contrario do [[Zhang]] e do [[Engel]], que usam ruido gaussiano sintetico, e do [[McClone]], que assume o input perfeito]

### O que os papers dizem

- [[Engel]]: usar a partida estimada ajuda, mesmo com erro, mas o erro e gaussiano, centrado no valor real e de so 0,5 h.
- [[Zhang]]: com erro realista o input prejudica, e a incerteza do utilizador reduz a energia entregue em 17% a 26%. A difusao corrige parte. O erro tambem e sintetico.
- [[Genov]]: diz que o input do utilizador nao e uma previsao fiavel da energia e da duracao, e usa os inputs reais do ACN-Data como referencia da precisao da previsao, mas nao dentro de um MPC.
- [[McClone]]: assume que o utilizador da a duracao e a energia certas.
- [[ACN-Sim]]: admite que o input pode estar errado.

### O que os papers nao provam

- Nenhum dos que li poe os erros reais dos utilizadores dentro de um MPC e mede o efeito no controlo.
- O ruido sintetico pode diferir do erro real, por exemplo se os utilizadores sobrestimam sempre ou arredondam as horas.
- Nao se confirmou que a partida estimada e a energia pedida estao preenchidas em todas as sessoes e em todos os sites do ACN. O Genov fala de registo de utilizadores, o que sugere que so alguns as preenchem.

### Como testar, como fator da ablacao

1. Ver antes quantas sessoes do ACN tem os dois campos preenchidos.
2. Quatro politicas de input: nenhum (so o previsor), o input bruto, o input corrigido por um modelo, e o input perfeito.
3. Medir a energia entregue, o pico e o custo, com os erros reais do ACN.
4. Repetir com erros gaussianos sinteticos, para ver se as conclusoes mudam.

Liga-se a H1 como uma opcao do operador: pedir ou nao o input ao utilizador. O resultado e util para empresas.
