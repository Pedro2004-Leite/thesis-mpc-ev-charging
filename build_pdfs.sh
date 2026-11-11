#!/usr/bin/env bash
# Compila todos os guias (Thesis LIterature/Guias/*.tex) com latexmk e copia os PDFs para a raiz do projeto.
# Nao fica nenhum residuo LaTeX. Uso: ./build_pdfs.sh
set -euo pipefail
cd "$(dirname "$0")"

for tex in "Thesis LIterature/Guias/"*.tex; do
  "Thesis LIterature/Guias/build.sh" "$(basename "$tex")"
  cp -f "${tex%.tex}.pdf" ./
done
