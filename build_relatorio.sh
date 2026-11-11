#!/usr/bin/env bash
# Compila o relatorio PIC2 (relatorio-overleaf/main.tex) com latexmk fora do repositorio e deixa so o PDF na raiz.
# Uso: ./build_relatorio.sh [nome-final]   (ex.: ./build_relatorio.sh 99999-Pedro-Leite -> 99999-Pedro-Leite.pdf)
set -euo pipefail
cd "$(dirname "$0")"
out="${1:-relatorio}"
tmp="$(mktemp -d)"
trap 'rm -rf "$tmp"' EXIT
latexmk -pdf -interaction=nonstopmode -halt-on-error -outdir="$tmp" -cd relatorio-overleaf/main.tex
cp -f "$tmp/main.pdf" "./$out.pdf"
echo "Pronto: $out.pdf (sem residuos no repositorio)"
