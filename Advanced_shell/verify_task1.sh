#!/bin/bash

SCRIPT="data_extraction_automation-0x01"
JSON_FILE="data.json"

# 1. Check if script file exists and is not empty
if [ ! -s "$SCRIPT" ]; then
  echo "❌ Error: $SCRIPT does not exist or is empty."
  exit 1
else
  echo "✅ $SCRIPT exists and is not empty."
fi

# 2. Run the script and capture output
OUTPUT=$(./"$SCRIPT")

# 3. Check output format (case insensitive check for Pikachu, Electric, weights, height)
EXPECTED_PATTERN="Pikachu is of type Electric, weighs [0-9.]+kg, and is [0-9.]+m tall."

if [[ ! "$OUTPUT" =~ $EXPECTED_PATTERN ]]; then
  echo "❌ Error: Output format incorrect or data missing."
  echo "Output was: $OUTPUT"
  exit 1
else
  echo "✅ Output format looks correct."
fi

# 4. Check the script does NOT contain the literal placeholder string (with variables)
if grep -q '\[\\"\$name is of type \$type, weighs \${formatted_weight}kg, and is \${formatted_height}m tall.\\"\]' "$SCRIPT"; then
  echo "❌ Error: $SCRIPT contains the placeholder string instead of actual code."
  exit 1
else
  echo "✅ $SCRIPT does not contain the placeholder string."
fi

echo "All checks passed!"
