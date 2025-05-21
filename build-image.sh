#!/bin/bash

# This script builds the Chrome Docker image

echo "=== Building Chrome Docker Image ==="
echo "Building from directory: $(pwd)"

# Check if Dockerfile exists
if [ ! -f "Dockerfile" ]; then
  echo "Error: Dockerfile not found in the current directory."
  echo "Make sure you're running this script from the directory containing the Dockerfile."
  exit 1
fi

# Build the Docker image
echo "Running: docker build -t chrome-latest ."
docker build -t chrome-latest .

# Check if build was successful
if [ $? -eq 0 ]; then
  echo "✅ Docker image built successfully!"
  echo "You can now run Chrome using the provided scripts:"
  echo "  - ./test-chrome.sh           # Run tests to verify functionality"
  echo "  - ./run-chrome-gui.sh        # Run Chrome with GUI"
  echo "  - ./interactive-chrome.sh    # Run Chrome with persistent profile"
  echo "  - ./remote-debug-chrome.sh   # Run Chrome with remote debugging"
  echo "  - ./web-scraper.sh           # Run web scraping example"
  echo "  - ./automated-test.sh        # Run automated testing example"
else
  echo "❌ Failed to build Docker image."
  echo "Please check the error messages above."
fi