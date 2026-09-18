#!/bin/bash
set -e

if [ -z "$1" ]; then
  echo "Usage: ./build_cover_pdf.sh <name> [namn]"
  echo "  name  - which cover file to build (e.g. nollan-ordinary-cover, nollan-forgotten-cover)"
  echo "  namn  - optional text to substitute for the [NAMN] placeholder"
  exit 1
fi

NAME="$1"
NAMN="$2"
SRC_TYP="${NAME}.typ"

TEMP_DIR="temp"
EXPORT_DIR="export"
SRC_PDF="${TEMP_DIR}/${NAME}.pdf"
OUT_PDF="${EXPORT_DIR}/${NAME}-spread.pdf"

if [ ! -f "$SRC_TYP" ]; then
  echo "Error: $SRC_TYP not found."
  exit 1
fi

mkdir -p "$TEMP_DIR" "$EXPORT_DIR"

# 1. Compile the chosen cover (two A5+bleed pages) into temp/
if [ -n "$NAMN" ]; then
  typst compile "$SRC_TYP" "$SRC_PDF" --input "namn=$NAMN"
else
  typst compile "$SRC_TYP" "$SRC_PDF"
fi

# 2. Impose it, cropped to A5, side by side on landscape A4, into export/
typst compile impose.typ "$OUT_PDF" --input "source=$SRC_PDF"

echo "Done -> $OUT_PDF"