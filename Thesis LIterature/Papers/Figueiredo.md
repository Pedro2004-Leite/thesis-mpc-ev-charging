---
title: Unsupervised Learning of Finite Mixture Models
authors: Figueiredo, Jain
year: 2002
venue: IEEE Transactions on Pattern Analysis and Machine Intelligence 24(3), 381-396
pdf: Anexos/Figueiredo.pdf
role: metodo para ajustar o GMM e escolher o numero de componentes
tags: [paper]
prioridade: 21
status: por-ler
lido_em: 
confirmado: nao
---

# Figueiredo

## Resumo

Propoe um algoritmo para ajustar misturas finitas (aqui ilustrado com misturas gaussianas) que escolhe o numero de componentes no proprio ajuste.
Em vez de ajustar varios modelos candidatos e escolher por um criterio, integra estimacao e selecao num so algoritmo, com um criterio de minimum message length.
Comeca com muitos componentes e elimina os que o dados nao suportam (component annihilation).
Nao precisa de inicializacao cuidadosa, ao contrario do EM padrao, e evita estimativas singulares na fronteira do espaco de parametros.

## Incertezas tratadas

- [[Incerteza: carros eletricos]]

## Temas

- [[Previsao de EVs]]
- [[Previsao probabilistica]]

## Associacao com papers anteriores

Proposta inicial minha, por confirmar apos a leitura:

- [[Amara]]: ajusta GMMs por EM e escolhe o numero de componentes por BIC testando K de 2 a 30, enquanto aqui a escolha e feita dentro do algoritmo
- [[Engel]] e [[Zhang]]: usam GMMs com numero de componentes fixo (3, 2 e 6 no Engel, 4, 4 e 2 no Zhang) sem dizer como o escolheram

## Notas e por fazer

Referencia metodologica, nao estrutura a tese.
Serve se o ajuste do GMM por EM com BIC (Amara) der problemas de inicializacao ou de singularidades.
Recomendado pelo professor de deep learning do aluno.

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

PDF: [[Figueiredo.pdf]]
