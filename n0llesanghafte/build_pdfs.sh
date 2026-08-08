#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
EXPORT_DIR="$SCRIPT_DIR/export"
PERSONALEN_DIR="$SCRIPT_DIR/data/personalen images"
MANIFEST="$PERSONALEN_DIR/manifest.json"

# Update personalen images manifest
echo "Updating personalen images manifest..."
{
    echo "{"
    first=true
    while IFS= read -r -d '' file; do
        filename="$(basename "$file")"
        # Skip manifest.json itself
        if [[ "$filename" == "manifest.json" ]]; then
            continue
        fi
        # Extract name without extension
        name="${filename%.*}"
        
        if [ "$first" = true ]; then
            echo "    \"$name\": \"$filename\""
            first=false
        else
            echo "    \"$name\": \"$filename\""
        fi
    done < <(find "$PERSONALEN_DIR" -maxdepth 1 -type f \( -name "*.jpg" -o -name "*.png" -o -name "*.svg" \) -print0 | sort -z)
    echo "}"
} > "$MANIFEST"

# Format JSON properly with commas
python3 -c "
import json
import sys

with open('$MANIFEST', 'r') as f:
    # Read line by line and build dict
    lines = [line.strip() for line in f if line.strip() and line.strip() not in ['{', '}']]
    
data = {}
for line in lines:
    if ':' in line:
        key, val = line.split(':', 1)
        key = key.strip().strip('\"')
        val = val.strip().strip('\"').rstrip(',')
        data[key] = val

with open('$MANIFEST', 'w') as f:
    json.dump(data, f, indent=4, ensure_ascii=False)
    f.write('\n')
"

echo "Manifest updated with $(jq 'length' "$MANIFEST") images"

# Copy songs.json into the project root so Typst can access it within its sandbox.
# The copy is kept after the build so that `typst preview` continues to work.
echo "Copying songs.json..."
cp "$SCRIPT_DIR/../songs.json" "$SCRIPT_DIR/songs.json"

# Build PDFs
mkdir -p "$EXPORT_DIR"

files=(
    blank
    dosq
    nollan
    storasyskon
    toast
)

echo ""
echo "Building PDFs..."
for name in "${files[@]}"; do
    echo "Building $name.typ -> export/$name.pdf"
    typst compile "$SCRIPT_DIR/$name.typ" "$EXPORT_DIR/$name.pdf"
done

echo ""
echo "Done. PDFs written to export/"
