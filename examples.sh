#!/bin/bash

# Build the Docker image
echo "Building Docker image..."
docker build -t chrome-latest .

# Check Chrome version
echo -e "\nChecking Chrome version:"
docker run --rm chrome-latest

# Take a screenshot of a website
echo -e "\nTaking a screenshot of google.com:"
docker run --rm -v $(pwd):/home/chrome/output chrome-latest \
  $CHROME_FLAGS --screenshot=/home/chrome/output/screenshot.png https://www.google.com

# Print the HTML of a website
echo -e "\nPrinting the HTML of google.com:"
docker run --rm chrome-latest \
  $CHROME_FLAGS --dump-dom https://www.google.com | head -n 20

# Run a simple performance test
echo -e "\nRunning a simple performance test:"
docker run --rm chrome-latest \
  $CHROME_FLAGS --run-performance-benchmark https://www.google.com