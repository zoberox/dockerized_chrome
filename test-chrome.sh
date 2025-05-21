#!/bin/bash

# This script tests if the Chrome Docker container is working correctly

# Make sure output directory exists
mkdir -p output

echo "=== Testing Chrome in Docker ==="
echo

# Test 1: Check Chrome version
echo "Test 1: Checking Chrome version..."
docker run --privileged --rm chrome-latest --version
if [ $? -eq 0 ]; then
  echo "✅ Test 1 passed: Chrome version check successful"
else
  echo "❌ Test 1 failed: Could not get Chrome version"
fi
echo

# Test 2: Take a screenshot
echo "Test 2: Taking a screenshot..."
docker run --privileged --rm -v $(pwd)/output:/home/chrome/output chrome-latest \
  --screenshot=/home/chrome/output/test-screenshot.png https://www.google.com
if [ -f "output/test-screenshot.png" ]; then
  echo "✅ Test 2 passed: Screenshot created successfully"
  echo "   Screenshot saved to: $(pwd)/output/test-screenshot.png"
else
  echo "❌ Test 2 failed: Could not create screenshot"
fi
echo

# Test 3: Dump DOM
echo "Test 3: Dumping DOM..."
docker run --privileged --rm chrome-latest --dump-dom https://example.com > output/test-dom.html
if [ -s "output/test-dom.html" ]; then
  echo "✅ Test 3 passed: DOM dumped successfully"
  echo "   DOM saved to: $(pwd)/output/test-dom.html"
else
  echo "❌ Test 3 failed: Could not dump DOM"
fi
echo

# Test 4: PDF Export
echo "Test 4: Exporting PDF..."
docker run --privileged --rm -v $(pwd)/output:/home/chrome/output chrome-latest \
  --print-to-pdf=/home/chrome/output/test-page.pdf https://example.com
if [ -f "output/test-page.pdf" ]; then
  echo "✅ Test 4 passed: PDF exported successfully"
  echo "   PDF saved to: $(pwd)/output/test-page.pdf"
else
  echo "❌ Test 4 failed: Could not export PDF"
fi
echo

echo "=== Test Summary ==="
echo "Check the output directory for generated files: $(pwd)/output/"
echo "If all tests passed, your Chrome Docker container is working correctly!"