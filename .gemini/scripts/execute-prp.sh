#!/bin/bash

# ---
# execute-prp.sh (v10 - With Robust `while read` Loop)
#
# Description:
#   The definitive agent script. It uses `awk` to parse the AI plan
#   and a robust `while read` loop to process and execute each action.
# ---

# 1. Validate Input & Environment
# --------------------------------
if [ -z "$GEMINI_API_KEY" ]; then
  echo "Error: GEMINI_API_KEY environment variable is not set."
  exit 1
fi
if ! command -v jq &> /dev/null || ! command -v awk &> /dev/null; then
    echo "Error: jq and awk are required. Please install them."
    exit 1
fi
if [ -z "$1" ]; then
  echo "Error: No PRP file specified."
  exit 1
fi

PRP_FILE_PATH=$1
if [ ! -f "$PRP_FILE_PATH" ]; then
  echo "Error: PRP file '$PRP_FILE_PATH' not found."
  exit 1
fi

# 2. Define the Execution Prompt
# ------------------------------
EXECUTE_PRP_PROMPT=$(cat <<'END_PROMPT'
You are an expert-level AI software engineer. Your task is to implement the feature described in the provided Product Requirements Prompt (PRP).

You MUST respond with a sequence of executable actions. Do NOT add any conversational text, explanations, numbering, or any text that is not part of an action block. Your entire response must be a sequence of these blocks.

There are only two types of blocks you can use:

1. A shell command to be executed. The block MUST start with ```bash on its own line and end with ``` on its own line.
   ```bash
   cargo new my-project
   ```

2. A file to be created or modified. The block MUST start with a line containing ONLY `CREATE path/to/file.ext` or `MODIFY path/to/file.ext`, followed by the language fence (e.g., ```rust) on the next line, the code, and a final ``` on its own line.
   CREATE src/main.rs
   ```rust
   fn main() {}
   ```

Generate the complete sequence of these blocks to implement the feature.
END_PROMPT
)

# 3. Send PRP to Gemini and Get the Plan
# --------------------------------------
PRP_CONTENT=$(cat "$PRP_FILE_PATH")
FULL_PROMPT="${EXECUTE_PRP_PROMPT}\n\nHere is the PRP to execute:\n---\n${PRP_CONTENT}"

echo "🤖 Sending PRP to Gemini to generate an implementation plan..."

JSON_PAYLOAD=$(jq -n --arg prompt "$FULL_PROMPT" \
                  '{ "contents": [ { "parts": [ { "text": $prompt } ] } ] }')

API_RESPONSE=$(curl -s -X POST "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=${GEMINI_API_KEY}" \
-H "Content-Type: application/json" \
-d "$JSON_PAYLOAD")

AI_PLAN=$(echo "$API_RESPONSE" | jq -r '.candidates[0].content.parts[0].text')

if [ -z "$AI_PLAN" ] || [ "$AI_PLAN" == "null" ]; then
    echo "Error: Could not get a valid plan from the API."
    echo "Full API Response:"
    echo "$API_RESPONSE"
    exit 1
fi

echo "✅ AI has generated the following plan:"
echo "--------------------------------------------------"
echo "$AI_PLAN"
echo "--------------------------------------------------"

# 4. Parse the Plan using AWK into structured blocks
# --------------------------------------------------
PARSED_PLAN=$(echo "$AI_PLAN" | awk '
function print_block() {
    if (type != "") {
        # Print the header line, then the content, then the separator
        print type " " path;
        print content;
        print "<--BLOCK_SEPARATOR-->";
    }
    # Reset state
    in_block = 0;
    type = "";
    path = "";
    content = "";
}

/^(CREATE|MODIFY) / { print_block(); type = $1; path = $2; getline; in_block = 1; next; }
/^```bash/ { print_block(); type = "COMMAND"; path = ""; in_block = 1; next; }
/^```/ { print_block(); next; }
{ if (in_block) {
    if (content == "") content = $0;
    else content = content "\n" $0;
  }
}
END { print_block(); } # Print any final block
')

# 5. Execute the Parsed Plan (Robust `while read` loop)
# -----------------------------------------------------
echo "🤖 Starting execution of the parsed plan..."

# Use a while loop to process the awk output block by block.
# This is the most robust way to handle multi-line input in bash.
while IFS= read -r header; do
    content=""
    while IFS= read -r line && [[ "$line" != "<--BLOCK_SEPARATOR-->" ]]; do
        if [ -z "$content" ]; then
            content="$line"
        else
            content="$content\n$line"
        fi
    done

    action=$(echo "$header" | awk '{print $1}')
    filepath=$(echo "$header" | awk '{print $2}')

    if [ "$action" == "COMMAND" ]; then
        echo -e "\n🔥 AI wants to execute command:"
        echo "--- Command: ---"
        echo -e "$content"
        echo "----------------"
        read -p "Proceed? [y/n] " -n 1 -r REPLY </dev/tty
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            echo "✅ Action approved. Executing command..."
            eval "$(echo -e "$content")"
        else
            echo "❌ Action skipped by user."
        fi
    elif [ "$action" == "CREATE" ] || [ "$action" == "MODIFY" ]; then
        echo -e "\n🔥 AI wants to $action file: $filepath"
        echo "--- Code: ---"
        echo -e "$content"
        echo "---------------"
        read -p "Proceed? [y/n] " -n 1 -r REPLY </dev/tty
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            mkdir -p "$(dirname "$filepath")"
            echo -e "$content" > "$filepath"
            echo "✅ Action approved. File '$filepath' has been written."
        else
            echo "❌ Action skipped by user."
        fi
    fi
done <<< "$PARSED_PLAN"

echo -e "\n🎉 Plan execution complete."
