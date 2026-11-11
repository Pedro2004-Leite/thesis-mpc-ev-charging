# Thesis project: MPC for EV chargers and battery under uncertainty

Context: MPC for chargers and a stationary battery, three uncertainty sources (PV, building, EVs), ACN-Sim as the validation platform, pandapower for the grid in closed loop, and a diffusion-based EV forecaster feeding the MPC (scenario a).
The Obsidian vault is `Thesis LIterature/` (the typo in the folder name is intentional history, do not rename).
Vault notes are ASCII Portuguese without accents. Guides (`Guias/*.tex`) are Portuguese with accents.
Do not create the code skeleton until the user asks.

## Layout

- `papers_buffer/` - inbox for new PDFs, see below.
- `Thesis LIterature/Anexos/` - every paper PDF, named `<ShortName>.pdf`.
- `Thesis LIterature/Papers/` - one note per paper, from `Templates/Paper.md`.
- `Thesis LIterature/Topics/` - theme and uncertainty notes that structure the graph.
- `Thesis LIterature/Guias/` - LaTeX guides (`ordem-de-leitura.tex`, `plano-da-tese.tex`, `guia-integracao.tex`). Only guides become PDFs, never the vault notes.
- Guide PDFs are copied to the project root by `./build_pdfs.sh`, which also leaves no LaTeX residue. Rebuild after any `.tex` change.

## Paper buffer (`papers_buffer/`, project root)

The user drops new PDFs in `papers_buffer/`. Check it at the start of every session and whenever the user mentions new papers.
A PDF in the buffer is not yet in the vault.

For each PDF in the buffer:

1. Read it (first pages at least) to get title, authors, year, venue, and to judge relevance.
2. Relevance: does it bring ideas for the thesis? Relevant topics are MPC or stochastic MPC for EV charging and battery, PV, building or EV forecasting (especially probabilistic and diffusion models), ACN-Sim, ACN-Data, pandapower or grid constraints in the controller, closed-loop co-simulation, and models for structuring the final paper.
3. If it has no relevant ideas: tell the user, say why in one or two sentences, and leave the PDF in the buffer. Do not add it to the vault unless the user says so.
4. If it is relevant: move it to `Anexos/<ShortName>.pdf` (the buffer ends up empty of processed files). Create `Papers/<ShortName>.md` from `Templates/Paper.md`. Fill what the paper itself gives (title, authors, year, venue, summary, uncertainties, themes, method and data), leave the rest as `por preencher`, and add `PDF: [[<ShortName>.pdf]]` at the end.
5. Link it from the relevant `Topics/` notes, from `Home.md`, and from the ordered list in `Ordem de leitura.md`.
6. Add a row to the table in `Guias/ordem-de-leitura.tex` with an unticked box (`\ckN`), choose its priority position, renumber, and rebuild with `./build_pdfs.sh`.
7. Report to the user what was added and where it sits in the order, then run the question round below.

## After reading a paper (question round)

Ask the user the questions only they can answer, then write the answers into the note. Ask them in one batch, with concrete proposals to confirm or correct, not open blanks:

1. What was taken from it (what is useful for the thesis)?
2. Which previous papers does it relate to, and how (extends, contradicts, uses as baseline, same data)? Propose links from what you read.
3. Its role in the thesis (method, baseline, data, framing, tool).
4. How it will be used (which chapter, which experiment).
5. Limitations or criticisms the user sees.
6. Open questions, and anything to cite verbatim.
7. Does its priority in the reading order change?

After the answers: fill the note sections (`O que foi retirado`, `Associacao com papers anteriores`, `Contribuicao para a tese`, `Limitacoes e criticas`, `Perguntas em aberto`, `Citacoes a usar`), set `confirmado: sim`, update related notes and Topics links, and update the paper's `Associacao` on the older papers it relates to.

## Reading ticks

When the user says a paper was read (or asks to tick it):
- In `Guias/ordem-de-leitura.tex`, change that row's `\ckN` to `\ckY`.
- In `Papers/<Name>.md`, set `status: lido` and `lido_em: <date>`.
- Rebuild with `./build_pdfs.sh`.
Do not tick anything on your own initiative.

## Main deliverable: PIC2 report

The PIC2 report is written in **English** (user decision, 2026-11-09). The thesis work feeds a PIC2 report (preparation and planning of the dissertation), evaluated by a jury (one supervisor plus one external member).
- Submit electronically via Fenix (Projetos, "Relatorio PIC2") as a PDF by **2027-01-06**.
- File name must be `<num_aluno-Nome-Apelido>.pdf` (example `99999-Manuel-Silva.pdf`). Student: Pedro Antonio Salazar Leite, number 106812, so the file is `106812-Pedro-Leite.pdf` (assumed Nome=Pedro, Apelido=Leite, to confirm).
- Required sections (regulation point 5):
  1. Motivacao e definicao do problema em estudo na Dissertacao
  2. Enquadramento do tema na area cientifica e revisao do estado da arte
  3. Definicao e proposta de metodologias a usar, com vista a consecucao dos objetivos da Dissertacao
  4. Resultados esperados e eventuais resultados preliminares
  5. Planificacao e calendarizacao do trabalho a desenvolver na Dissertacao
- Source is the Overleaf project (Git, Student plan) cloned at `relatorio-overleaf/` (main file `main.tex`, remote `https://git@git.overleaf.com/6af24cb1d2c227248fba54af`). It is a nested git repo and the single source of truth. Do not keep a second copy.
- Local build: `./build_relatorio.sh [final-name]` (latexmk out of tree, leaves only the PDF in the project root, nothing in the repo).
- Overleaf sync: `git pull` before editing, commit and `git push` after. The user may also edit online. Commit messages in Portuguese, no co-author line.
- Auth: token as password with username `git`. Never write the token to any file, the git config or memory. Read it from the environment variable `OVERLEAF_TOKEN` via a temporary `GIT_ASKPASS` script and pass `-c http.proactiveAuth=basic` (Overleaf answers 403 instead of 401 otherwise). If the variable is not set, ask the user. The token that was pasted in chat on 2026-11-09 should be revoked and replaced.
- The report is a deliverable, not a vault note or guide.
- Mapping from the vault: sections 1 and 2 come from `Papers/`, `Topics/` and `Hipotese.md`. Section 3 from `Guias/guia-integracao.tex` and the thesis plan phases. Section 4 from the plan (expected) and any prototype results (preliminary). Section 5 from `Guias/plano-da-tese.tex`, which still has no calendar.
