#!/bin/bash

# Example of using Chrome in Docker for web scraping
# This script demonstrates how to extract information from a webpage

# Make sure output directory exists
mkdir -p output

# URL to scrape
URL="https://news.ycombinator.com/"

echo "=== Web Scraping with Chrome in Docker ==="
echo "Target URL: $URL"
echo

# Extract titles from Hacker News
echo "Extracting top stories from Hacker News..."
docker run --rm chrome-latest --headless --disable-gpu --js-flags="--max_old_space_size=2048" --run-all-compositor-stages-before-draw --virtual-time-budget=10000 --dump-dom "$URL" > output/hackernews.html

# Process the HTML to extract titles (using grep and sed)
echo "Processing results..."
cat output/hackernews.html | grep -o '<a href="item?id=[^"]*">[^<]*</a>' | sed 's/<a href="item?id=[^"]*">\(.*\)<\/a>/\1/' > output/top_stories.txt

# Count and display results
STORY_COUNT=$(wc -l < output/top_stories.txt)
echo "Found $STORY_COUNT stories. Here are the top 10:"
echo "----------------------------------------"
head -n 10 output/top_stories.txt
echo "----------------------------------------"
echo
echo "Full results saved to: $(pwd)/output/top_stories.txt"
echo
echo "=== Scraping Complete ==="