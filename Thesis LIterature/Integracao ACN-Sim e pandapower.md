---
tags: [guia, simulacao]
---

# Integracao ACN-Sim e pandapower

Guia completo (com codigo testado): [[guia-integracao.pdf]].
Fonte LaTeX em `Guias/guia-integracao.tex`, pronta a colar no Overleaf.

## O que a documentacao diz

- O paper [[ACN-Sim]] diz que a integracao com MATPOWER, PandaPower e OpenDSS e sequencial: a saida do ACN-Sim serve de entrada ao simulador de rede.
- O mesmo paper diz que o feedback da rede para o ACN-Sim fica para versoes futuras.
- O pacote `acnportal` 0.3.3 (de novembro de 2023, o que esta instalado) nao tem codigo de rede. O codigo de integracao esta no repositorio `caltech-netlab/acnportal-experiments`.
- Conclusao: a co-simulacao em malha fechada nao existe feita. Temos de a construir, e isso e uma contribuicao da tese.

## Pontos de acoplamento

- `BaseAlgorithm.schedule()` e o sitio do MPC. Com `max_recompute = 1` e chamado em cada periodo.
- `interface.last_actual_charging_rate` devolve as correntes (A) do periodo anterior. E a entrada do power flow.
- A leitura da rede chega ao MPC com um periodo de atraso. Isto e realista e liga-se a latencia tratada em [[Pajic]].
- `P [kW] = I [A] x V / 1000`, com a tensao do EVSE.

## Rede proposta

- Rede propria em pandapower, parametrica, em vez da CIGRE LV (que ja esta a 0.912 pu sem EVs no alimentador comercial).
- Configuracao A (forte): transformador de 630 kVA dedicado, 80 m de cabo (3 em paralelo). A tensao nao e restricao ativa, a restricao e o transformador e o pico.
- Configuracao B (fraca): cabo de 300 m partilhado. A tensao desce abaixo de 0.95 pu por volta dos 60 kW de EVs.
- Trifasico: `runpp_3ph` funciona se fornecermos os dados de sequencia zero, que os tipos standard nao trazem.

Detalhes e numeros no guia.
