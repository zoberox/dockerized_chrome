#!/bin/bash

# This script demonstrates how to run Chrome in interactive GUI mode
# with various customizations

# Check if X server is running on the host
if [ -z "$DISPLAY" ]; then
  echo "Error: No DISPLAY environment variable set."
  echo "Make sure you have an X server running on your host machine."
  exit 1
fi

# Allow connections from Docker to the X server
xhost +local:docker || {
  echo "Error: Failed to run 'xhost +local:docker'"
  echo "You may need to install xhost or run this script with appropriate permissions."
  echo "Try: sudo apt-get install x11-xserver-utils"
  exit 1
}

# Create a directory for Chrome user data
mkdir -p output/chrome-data

echo "=== Interactive Chrome Browser from Docker ==="
echo "Starting Chrome with a persistent profile..."

# Run Chrome with GUI and a persistent profile
docker run --privileged --rm \
  -e DISPLAY=$DISPLAY \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  -v $(pwd)/output:/home/chrome/output \
  -v $(pwd)/output/chrome-data:/home/chrome/.config/google-chrome \
  --shm-size=2g \
  chrome-latest --gui \
  --user-data-dir=/home/chrome/.config/google-chrome \
  --start-maximized \
  https://www.google.com

# Revoke X server access when done
xhost -local:docker

echo "Chrome session ended. Your browsing data is saved in: $(pwd)/output/chrome-data"