---
tags: [index]
---

# Tese: MPC para carregadores e bateria sob incerteza

Controlador MPC para carregadores de EVs e bateria, com tres fontes de incerteza.
Validacao com ACN-Sim e co-simulacao em malha fechada com pandapower.

## Navegacao

- [[Hipotese]]
- [[Ordem de leitura]]
- [[Plano da tese]]
- [[Integracao ACN-Sim e pandapower]]

## Hipotese

- Cenario a): o previsor de difusao alimenta o MPC. Ver [[Hipotese]].

## Incertezas

- [[Incerteza: paineis solares]]
- [[Incerteza: edificio]]
- [[Incerteza: carros eletricos]]

## Temas

- [[MPC]]
- [[MPC estocastico]]
- [[MPC para carregamento]]
- [[Sistemas integrados PV+bateria+EV]]
- [[Previsao de EVs]]
- [[Previsao de PV]]
- [[Previsao probabilistica]]
- [[Modelos de difusao]]
- [[Comportamento e dados de EVs]]
- [[Restricoes de tensao e rede]]
- [[Simulacao e co-simulacao]]
- [[Modelo de paper (teoria ate a pratica)]]
- [[Esqueleto da formulacao]]
- [[MPC distributionalmente robusto]]

## Papers

- [[ACN-Sim]]: ferramenta
- [[Lee]]: sistema ACN e escalonador MPC (ASA), complemento do ACN-Sim
- [[Genov]]: baseline de previsao
- [[Ran]]: baseline de previsao
- [[Cheng]]: baseline de previsao
- [[DiffPLF]]: metodo central da hipotese
- [[Zhang]]: paper mais proximo da tese
- [[Saleem]]: referencia de MPC estocastico e tensao, so controla a bateria
- [[Zhong]]: MPC distributionalmente robusto com dados, alternativa de tratamento de cenarios
- [[Engel]]: EMPC hierarquico com cenarios GMM (citado por Zhang)
- [[McClone]]: previsao de EVs por ML ligada ao MPC (citado por Zhang)
- [[Li]]: DiffCharge, cenarios de EVs por difusao (citado por Zhang)
- [[Amara]]: benchmark de previsao de sessoes de EVs, direta e bottom-up (citado por Zhang)
- [[Figueiredo]]: ajuste de misturas com escolha automatica do numero de componentes
- [[Mesbah]]: revisao de MPC estocastico, para o enquadramento
- [[Thurner]]: pandapower, ferramenta de rede
- [[Zheng]]: MPC de carregamento com OPF convexo e restricoes de tensao
- [[LiGuo]]: origem da formulacao com EVs correntes e futuros (citado por Zhang)
- [[Torres]]: referencia de sistema integrado
- [[Loparo]]: referencia de MPC para edificio
- [[Brown]]: previsao PV probabilistica + SMPC
- [[Grob]]: previsao PV probabilistica + SMPC
- [[Pajic]]: modelo de paper indicado pelo professor
