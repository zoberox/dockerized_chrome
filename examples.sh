#!/bin/bash

# Build the Docker image
echo "Building Docker image..."
docker build -t chrome-latest .

# Check Chrome version
echo -e "\nChecking Chrome version:"
docker run --rm chrome-latest

# Take a screenshot of a website
echo -e "\nTaking a screenshot of google.com:"
docker run --rm -v $(pwd)/output:/home/chrome/output chrome-latest \
  --headless --screenshot=/home/chrome/output/screenshot.png https://www.google.com

# Print the HTML of a website
echo -e "\nPrinting the HTML of google.com:"
docker run --rm chrome-latest \
  --headless --dump-dom https://www.google.com | head -n 20

# Run Chrome in non-headless mode (will display in Xvfb)
echo -e "\nRunning Chrome in non-headless mode (with Xvfb):"
docker run --rm chrome-latest https://www.google.com

# Run with increased shared memory
echo -e "\nRunning with increased shared memory:"
docker run --rm --shm-size=2g chrome-latest --headless https://www.google.com