#!/bin/bash

# Print the content of the YAML file
echo "Contents of sources.yaml:"
cat sources.yaml


# Convert the YAML file to JSON
json=$(python -c "import sys, yaml, json; json.dump(yaml.safe_load(sys.stdin), sys.stdout)" < sources.yaml)

# Print the JSON content
echo "JSON content:"
echo "$json"

# Extract URLs from the JSON content
LINEAGE_URL=$(echo "$json" | jq -r '.["LineageOS-20"].kernel[0]' | cut -d ' ' -f 3)
ZENITSU_URL=$(echo "$json" | jq -r '.Zenitsu.kernel[0] | split(" ")[2]')
DIVEST_URL=$(echo "$json" | jq -r '.["DivestOS-13"].kernel[0]' | cut -d ' ' -f 3)
LAVA_URL=$(echo "$json" | jq -r '.["vlad-experimental"].kernel[0]' | cut -d ' ' -f 3)

# Print extracted URLs
echo "Lineage URL: $LINEAGE_URL"
echo "Zenitsu URL: $ZENITSU_URL"
echo "Divest URL: $DIVEST_URL"
echo "Divest URL: $LAVA_URL"

# Set the extracted URLs as output parameters using the new method
echo "lineage_url=$LINEAGE_URL" >> $GITHUB_ENV
echo "zenitsu_url=$ZENITSU_URL" >> $GITHUB_ENV
echo "divest_url=$DIVEST_URL" >> $GITHUB_ENV
echo "lava_url=$lava_URL" >> $GITHUB_ENV
