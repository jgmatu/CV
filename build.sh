#!/usr/bin/env bash
# Genera el PDF del CV.
# Uso: ./build.sh [archivo.tex]
set -euo pipefail

cd "$(dirname "$0")"

src="${1:-CV_FJGMS_INDRA.tex}"

if [[ ! -f "$src" ]]; then
  echo "No se encuentra el archivo: $src" >&2
  exit 1
fi

if ! command -v pdflatex >/dev/null 2>&1; then
  cat >&2 <<'EOF'
No está instalado pdflatex.
En Ubuntu instálalo con:

  sudo apt-get update
  sudo apt-get install -y texlive-latex-extra texlive-fonts-recommended texlive-lang-english latexmk
EOF
  exit 1
fi

base="${src%.tex}"

if command -v latexmk >/dev/null 2>&1; then
  latexmk -pdf -interaction=nonstopmode -halt-on-error -file-line-error "$src"
else
  pdflatex -interaction=nonstopmode -halt-on-error -file-line-error "$src"
  pdflatex -interaction=nonstopmode -halt-on-error -file-line-error "$src"
fi

echo "PDF generado: $(pwd)/${base}.pdf"
