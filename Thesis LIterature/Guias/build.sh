#!/usr/bin/env bash
# Compila o guia com latexmk (o mesmo motor do Overleaf) e limpa todos os residuos: ficam apenas o .tex, o .pdf e este script.
# Uso: ./build.sh [ficheiro.tex]   (por omissao, guia-integracao.tex)
set -euo pipefail
cd "$(dirname "$0")"
tex="${1:-guia-integracao.tex}"

latexmk -pdf -interaction=nonstopmode -halt-on-error "$tex"
latexmk -c "$tex" >/dev/null
rm -f -- "${tex%.tex}.nav" "${tex%.tex}.snm" "${tex%.tex}.synctex.gz"

echo "Pronto: $(basename "${tex%.tex}").pdf (residuos limpos)"
