#!/bin/bash

# Example of using Chrome in Docker for automated testing
# This script demonstrates how to perform basic automated tests on a website

# Make sure output directory exists
mkdir -p output

# URL to test
URL="https://example.com"

echo "=== Automated Testing with Chrome in Docker ==="
echo "Target URL: $URL"
echo

# Test 1: Check if the website loads
echo "Test 1: Checking if website loads..."
docker run --privileged --rm chrome-latest --dump-dom "$URL" > /dev/null
if [ $? -eq 0 ]; then
  echo "✅ Website loaded successfully"
else
  echo "❌ Failed to load website"
  exit 1
fi

# Test 2: Check for specific content
echo "Test 2: Checking for specific content..."
docker run --privileged --rm chrome-latest --dump-dom "$URL" > output/content.html
if grep -q "Example Domain" output/content.html; then
  echo "✅ Found expected content: 'Example Domain'"
else
  echo "❌ Expected content not found"
fi

# Test 3: Check page title
echo "Test 3: Checking page title..."
docker run --privileged --rm chrome-latest --dump-dom "$URL" > output/title.html
TITLE=$(grep -o '<title>[^<]*</title>' output/title.html | sed 's/<title>\(.*\)<\/title>/\1/')
if [ "$TITLE" = "Example Domain" ]; then
  echo "✅ Page title is correct: '$TITLE'"
else
  echo "❌ Unexpected page title: '$TITLE'"
fi

# Test 4: Check page load performance
echo "Test 4: Checking page load performance..."
docker run --privileged --rm chrome-latest --run-all-compositor-stages-before-draw --virtual-time-budget=10000 --metrics-recording-only --dump-dom "$URL" > output/metrics.txt
echo "✅ Performance metrics collected"

# Test 5: Take a screenshot for visual verification
echo "Test 5: Taking screenshot for visual verification..."
docker run --privileged --rm -v $(pwd)/output:/home/chrome/output chrome-latest --screenshot=/home/chrome/output/test-screenshot.png "$URL"
if [ -f "output/test-screenshot.png" ]; then
  echo "✅ Screenshot captured for visual verification"
else
  echo "❌ Failed to capture screenshot"
fi

echo
echo "=== Test Summary ==="
echo "All tests completed. Check the output directory for detailed results: $(pwd)/output/"
echo "=== Testing Complete ==="