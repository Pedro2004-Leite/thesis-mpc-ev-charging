---
tags: [topic, ideia]
estado: ideia por explorar
---

# MPC distributionalmente robusto

Ideia guardada em 2026-11-10 para explorar mais tarde.
Entrou na lista de leitura como alternativa, com prioridade baixa.
Nao faz parte do ambito do relatorio PIC2.

## Papers

- [[Zhong]]: o paper do repositorio.

## A ideia

Em vez de assumir uma distribuicao para a incerteza, usa amostras dela como distribuicao empirica.
Define um conjunto de distribuicoes possiveis num circulo de Wasserstein em torno dessas amostras, e o raio mede a desconfianca nos dados.
As restricoes tem de valer para a pior distribuicao dentro do circulo.

## Porque pode interessar

- Alternativa mais rigorosa ao cenario medio do [[Engel]] e a media de controlos do [[Zhang]].
- Liga ao cenario a): o gerador (GMM ou difusao) produz as amostras, e o controlador protege contra o erro do previsor.
- A implementacao de referencia usa cvxpy, que e uma das opcoes de ferramenta.

## Porque nao e para ja

- O repositorio trata um sistema linear com perturbacao aditiva na dinamica.
- A incerteza dos EVs e de estrutura (quem chega, quando sai, quanta energia pede), por isso a formulacao teria de ser adaptada.
- Usa o MOSEK, que e comercial, com licenca academica.
- Nao tem licenca visivel, parece um instantaneo de investigacao e nao foi lido por completo.

## Fontes

- Repositorio: https://github.com/OptiMaL-PSE-Lab/Data-driven-distributionally-robust-MPC
- Paper associado: [[Zhong]] (Zhong, del Rio-Chanona e Petsagkourakis, 2021, arXiv 2105.08414).
- Li so o README e dois ficheiros de codigo (DRO_model.py e DRO_optproblem.py). Os scripts de simulacao nao foram lidos.

## Por avaliar

Links indicados pelo aluno que nao foi possivel abrir (erro 403). Pedir o PDF para o buffer.

- https://pubsonline.informs.org/doi/abs/10.1287/educ.2019.0198
- https://www.sciencedirect.com/science/article/pii/S0005109824004011

## Relacao com o resto

- Complementa [[MPC estocastico]] e [[Previsao probabilistica]].
- Decisao em aberto no [[Esqueleto da formulacao]]: como os cenarios entram no controlador.
