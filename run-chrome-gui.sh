#!/bin/bash

# This script runs Chrome with GUI from the Docker container

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

echo "Starting Chrome in GUI mode..."
echo "Note: This requires an X server running on your host machine."

# Run Chrome with GUI
docker run --privileged --rm \
  -e DISPLAY=$DISPLAY \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  -v $(pwd)/output:/home/chrome/output \
  chrome-latest --gui https://www.google.com

# Revoke X server access when done
xhost -local:docker