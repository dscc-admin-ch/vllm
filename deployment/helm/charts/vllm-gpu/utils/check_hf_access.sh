#!/bin/bash

MODEL_NAME=$1
HF_TOKEN=$2

# API endpoint
URL="https://huggingface.co/api/models/${MODEL_NAME}"

# Step 1: Check if the model is gated
echo "🔹 Checking model visibility for '$MODEL_NAME'..."
RESPONSE=$(curl -s "$URL" | jq .gated)

# If the model is public, allow access immediately
if [[ "$RESPONSE" == "false" ]]; then
    echo "✅ Model '$MODEL_NAME' is public. No token needed."
    exit 0
else
    echo "🔒 Model '$MODEL_NAME' is gated. Token required."
    if [[ -z "$HF_TOKEN" ]]; then
        echo "❌ No token provided. Access denied."
        exit 1
    fi
fi

# Step 2: If gated, check token access
echo "🔹 Checking access to '$MODEL_NAME' with provided token..."
CHECK_ACCESS=$(curl -s -H "Authorization: Bearer $HF_TOKEN" -I "https://huggingface.co/${MODEL_NAME}/resolve/main/config.json" | head -n 1)

if echo "$CHECK_ACCESS" | grep -E "HTTP/[0-9]\.?[0-9]* 200"; then
    echo "✅ Access granted to '$MODEL_NAME' with provided token."
    exit 0
else
    echo "❌ Access denied to '$MODEL_NAME' with provided token."
    exit 1
fi