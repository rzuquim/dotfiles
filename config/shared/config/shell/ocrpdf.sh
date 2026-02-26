#!/bin/bash

# usage:
#   ocrpdf_complex input.pdf
#   ocrpdf_complex rotate -90 input.pdf
#
# produces: <input>_output.pdf in current directory
# requires: pdftoppm, unpaper, img2pdf, ocrmypdf, qpdf
function ocrpdf_complex() {
  echo "THIS IS A WIP!"
  return 1

  if [[ $# -lt 1 ]]; then
    echo "usage: ocrpdf_complex [rotate <angle>] <input.pdf>" >&2
    return 1
  fi

  local rotate_flag=0
  local angle=""
  local input=""

  if [[ "$1" == "rotate" ]]; then
    if [[ $# -lt 3 ]]; then
      echo "usage: ocrpdf_complex rotate <angle> <input.pdf>" >&2
      return 1
    fi
    rotate_flag=1
    angle="$2"
    input="$3"
  else
    input="$1"
  fi

  if [[ ! -f "$input" ]]; then
    echo "error: input file not found: $input" >&2
    return 1
  fi

  local base output tmpdir imgdir splitdir
  base="$(basename "$input" .pdf)"
  output="${base}_output.pdf"

  tmpdir="$(mktemp -d /tmp/ocrcomplex.XXXXXX)"
  imgdir="$tmpdir/img"
  splitdir="$tmpdir/split"

  mkdir -p "$imgdir" "$splitdir"
  trap 'rm -rf "$tmpdir"' EXIT

  echo "[1/5] rasterizing PDF..."
  pdftoppm "$input" "$imgdir/page" -png || {
    echo "pdftoppm failed" >&2
    return 1
  }

  echo "[2/5] splitting double pages..."
  local i=1
  for f in "$imgdir"/page-*.png; do
    printf -v n "%04d" "$i"
    unpaper \
      --layout double \
      --output-pages 2 \
      --no-blackfilter \
      --no-blackfilter \
      --no-noisefilter \
      --border-scan-direction vertical \
      "$f" \
      "$splitdir/out-${n}a.png" \
      "$splitdir/out-${n}b.png" \
      >/dev/null
      if [[ $? -ne 0 ]]; then
        echo "unpaper failed" >&2
        return 1
      fi
    ((i++))
  done

  echo "[3/5] rebuilding PDF..."
  img2pdf "$splitdir"/out-*.png -o "$tmpdir/split.pdf" || {
    echo "img2pdf failed" >&2
    return 1
  }

  echo "[4/5] running OCR..."
  ocrmypdf "$tmpdir/split.pdf" "$tmpdir/ocr.pdf" || {
    echo "ocrmypdf failed" >&2
    return 1
  }

  if [[ "$rotate_flag" -eq 1 ]]; then
    echo "[5/5] rotating ${angle} degrees..."
    qpdf --rotate="${angle}:1-z" "$tmpdir/ocr.pdf" "$output" || {
        echo "rotation with qpdf failed" >&2
        return 1
    }
  else
    echo "[5/5] finalizing without rotation..."
    mv "$tmpdir/ocr.pdf" "$output"
  fi

  echo "done: $output"
}
