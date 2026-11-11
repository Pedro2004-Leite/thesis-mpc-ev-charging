---
tags: [plano]
---

# Plano da tese

Este plano parte de todo o contexto do projeto: MPC para carregadores e bateria, tres fontes de incerteza (PV, edificio, EVs), ACN-Sim como plataforma, pandapower em malha fechada, e o cenario a) da hipotese (o previsor de difusao alimenta o MPC).
Nao tem datas, porque o calendario da tese nao foi definido. Cada fase tem um criterio de conclusao, para saber quando passar a seguinte.

## Contribuicoes alvo

- **C1 - Co-simulacao em malha fechada ACN-Sim e pandapower.** O paper [[ACN-Sim]] diz que o feedback da rede e trabalho futuro. Ver [[Integracao ACN-Sim e pandapower]].
- **C2 - Valor da previsao no controlo, para varios perfis de operador.** Mede-se a qualidade do previsor pelo seu efeito no MPC (custo, pico, violacoes, energia entregue), nao so pelo erro de previsao, e pela distancia ao oraculo. O previsor de difusao e um dos candidatos. Parte de [[DiffPLF]] e [[Zhang]].
- **C3 - Estudo conjunto das tres incertezas** num sistema com PV, edificio, bateria e EVs, com restricoes de rede. Nenhum dos 17 papers cobre isto de ponta a ponta. O [[Saleem]] e o mais proximo nas tres incertezas e na tensao, mas so controla a bateria e trata os EVs como procura. O [[Engel]] controla os EVs com PV, bateria e edificio, mas sem rede. Nenhum tem difusao nem rede em malha fechada.
- **C4 - Garantias e validacao realista**, ao estilo de [[Pajic]]: erro de modelo e latencia tratados como parametros, e validacao proxima da vida real.

## Perguntas de investigacao

- **RQ1.** Quao perto do oraculo fica um MPC alimentado por previsores realistas, para varios perfis de operador, e quanto dessa distancia a previsao explica (hipotese H1)? Um previsor de difusao condicional melhora os resultados face a GMM, LightGBM e regressao quantilica (hipotese H2)? Ver [[Hipotese]].
- **RQ2.** Qual das tres incertezas (PV, edificio, EVs) mais degrada o desempenho do controlo?
- **RQ3.** O feedback da rede muda as conclusoes face a uma validacao sequencial (sem feedback)?
- **RQ4.** Os resultados mantem-se com redes mais fracas, outros sites e outras epocas do ano?

## Fases

### Fase 0 - Fundacoes
- Ler os papers pela [[Ordem de leitura]] (passos 1 a 4 primeiro).
- Ambiente em `.venv` (feito): `acnportal`, `pandapower`, `cvxpy`, `numba`.
- Conclusao: consegues explicar, sem consultar, o ciclo do ACN-Sim e a formulacao de [[Zhang]] e [[Engel]].

### Fase 1 - Dados
- Pedir o token do ACN-Data e descarregar sessoes de um site (Caltech, JPL ou Office001). A confirmar o procedimento no portal do ACN.
- Escolher dados de PV (por exemplo PVGIS ou NREL) e de carga de edificio, a confirmar a licenca e a resolucao temporal.
- Definir a divisao treino, validacao e teste por tempo, sem fuga de informacao do futuro.
- Conclusao: um dataset alinhado a 5 ou 15 minutos, com PV, edificio e sessoes de EVs, e um README com as fontes.

### Fase 2 - Rede e co-simulacao (C1)
- Construtor parametrico da rede em pandapower ([[Thurner]]), com a configuracao A (forte) e B (fraca) do guia.
- Ciclo em malha fechada: o MPC ve a tensao do periodo anterior.
- Reproduzir primeiro o case study sequencial do ACN-Sim, para validar a tubagem antes de a mudar.
- Tratar a nao-convergencia do power flow como evento.
- Conclusao: um dia simulado com controlador trivial, resultados iguais no modo sequencial e no modo malha fechada com feedback desligado.

### Fase 3 - Baselines de controlo
- Sem controlo, algoritmos do `acnportal` (FCFS, EDF, LLF), MPC deterministico com previsao perfeita (limite superior) e com persistencia.
- Conclusao: tabela de baselines com custo, pico, violacoes e energia entregue, num intervalo de dias de teste.

### Fase 4 - Previsores (H1 e H2)
- PV: persistencia, regressao quantilica, e um modelo probabilistico ao estilo de [[Brown]] e [[Grob]].
- Edificio: persistencia sazonal e um modelo simples, ao estilo de [[Loparo]].
- EVs: GMM e LightGBM ([[Genov]]), regressao quantilica, e difusao condicional generativa ([[DiffPLF]], [[Li]]).
- Metricas: CRPS, pinball loss, calibracao da cobertura, e erro pontual para comparar com [[Ran]] e [[Cheng]].
- Conclusao: tabela de previsores com intervalos de confianca por bootstrap, e o veredicto sobre H2 ao nivel da previsao.

### Fase 5 - MPC estocastico
- MPC por cenarios, com amostras dos previsores da Fase 4, para que o mesmo controlador aceite qualquer previsor.
- A formulacao dos EVs vem do [[Engel]] (por carregador) e do [[Zhang]] (por evento). A estrutura estocastica e a tensao podem seguir o [[Saleem]], que so controla a bateria.
- Por decidir como os cenarios entram (media, um MPC por cenario, ou um problema unico). Ver [[Esqueleto da formulacao]].
- Alternativa a avaliar depois de o MPC por cenarios estar estavel: MPC distributionalmente robusto ([[Zhong]]), que usa as amostras do previsor com um circulo de Wasserstein. Pode ajustar-se ao PV, ao edificio e a perturbacoes agregadas de chegadas de EVs, mas assume sistema linear e perturbacao aditiva.
- Restricoes de rede no MPC com um modelo linearizado (sensibilidades do power flow), e o power flow AC completo como planta.
- Bateria estacionaria como modelo proprio, porque o modelo de bateria do ACN-Sim e o dos EVs.
- Conclusao: o MPC corre em tempo util (passo de 5 min), com um perfil de tempo por passo.

### Fase 6 - Experiencias em malha fechada (C2, C3)
- Fatorial: previsor (perfeito, persistencia, GMM, LightGBM, quantilica, difusao) por controlador (deterministico, estocastico) por rede (A, B) por feedback (ligado, desligado) por perfil de operador (custo, pico e rede, utilizadores).
- Ablacoes: tornar perfeita uma incerteza de cada vez (PV, edificio, EVs) para responder a RQ2.
- Robustez: treinar num site e testar noutro, e testar noutra epoca do ano (RQ4).
- Estatistica: varias sementes, intervalos de confianca, testes pareados por dia.
- Conclusao: tabelas e figuras prontas para a tese, com um script que as regenera do zero.

### Fase 7 - Garantias e erro de modelo (C4)
- Quantificar a diferenca entre o modelo linearizado do MPC e a planta AC (erro de modelo).
- Limitar a violacao de restricoes em funcao do erro de previsao e do atraso de medida, ao estilo de [[Pajic]].
- Conclusao: um resultado que se possa enunciar como proposicao, com verificacao numerica.

### Fase 8 - Validacao proxima da vida real (C4)
- Opcoes por ordem de realismo: dados reais de um site em replay, hardware-in-the-loop, teste num site real.
- Perguntar ao professor que opcao e viavel. O paper [[ACN-Sim]] menciona o ACN-Live para testes em hardware real, mas o acesso esta por confirmar.
- Conclusao: pelo menos uma validacao com dados ou hardware reais, para fechar o arco de teoria a pratica.

### Fase 9 - Escrita
- Estrutura da tese: introducao, estado da arte (a partir da vault), modelo, previsores, controlador, co-simulacao, resultados, conclusoes.
- Papers possiveis: P1 a co-simulacao em malha fechada (C1), P2 difusao no controlo (C2), P3 o estudo completo (C3 e C4).
- Reler [[Pajic]] aqui para a narrativa.
- Conclusao: primeiro rascunho completo, com todas as figuras regeneraveis.

## Riscos

| Risco | Mitigacao |
|-------|-----------|
| O paper da hipotese (Jeste e Kamaci) nao esta disponivel | Implementar a difusao a partir de [[DiffPLF]] e [[Zhang]], e atualizar quando sair |
| Cenarios no MPC tornam o passo lento | Medir cedo, reduzir cenarios por amostragem estratificada, usar solvers rapidos |
| O power flow nao converge em casos extremos | Tratar como evento, limitar o desequilibrio, registar a frequencia |
| Dados de um so local (ACN-Data e da California) limitam a generalizacao | Testar em varios sites do ACN-Data e discutir a limitacao |
| Ambito demasiado grande | Fechar as fases 1 a 6 antes das 7 e 8; a fase 8 e o que mais pode escorregar |
| A rede escolhida nao e representativa | Duas configuracoes (A e B) e uma varredura da forca da rede |

## Ordem recomendada

Fases 0 a 3 primeiro, porque dao uma base que corre de ponta a ponta.
A Fase 4 pode correr em paralelo com a Fase 5.
As fases 7 e 8 so depois de a Fase 6 ter resultados estaveis.
