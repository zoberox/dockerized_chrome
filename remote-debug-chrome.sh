#!/bin/bash

# This script demonstrates how to run Chrome with remote debugging enabled
# This allows you to connect to Chrome using tools like Puppeteer, Selenium, or Chrome DevTools

# Create output directory
mkdir -p output

# Define the debugging port
DEBUG_PORT=9222

echo "=== Starting Chrome with Remote Debugging ==="
echo "Remote debugging will be available at http://localhost:$DEBUG_PORT"

# Run Chrome with remote debugging enabled
docker run --privileged --rm \
  -p $DEBUG_PORT:$DEBUG_PORT \
  -v $(pwd)/output:/home/chrome/output \
  chrome-latest \
  --remote-debugging-address=0.0.0.0 \
  --remote-debugging-port=$DEBUG_PORT \
  https://www.google.com

echo "Chrome with remote debugging has been stopped."