#!/bin/bash

# This script helps set up the Chrome Docker environment

echo "=== Chrome Docker Setup ==="

# Create necessary directories
mkdir -p output
echo "✅ Created output directory"

# Make all scripts executable
chmod +x *.sh
echo "✅ Made all scripts executable"

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
  echo "❌ Docker is not installed or not in PATH"
  echo "Please install Docker first:"
  echo "  Ubuntu/Debian: sudo apt-get install docker.io"
  echo "  Fedora: sudo dnf install docker"
  echo "  Arch: sudo pacman -S docker"
  exit 1
else
  echo "✅ Docker is installed"
fi

# Check if user can run Docker without sudo
if docker info &> /dev/null; then
  echo "✅ You can run Docker without sudo"
else
  echo "⚠️ You may need to run Docker commands with sudo"
  echo "To avoid using sudo, you can add your user to the docker group:"
  echo "  sudo usermod -aG docker $USER"
  echo "  (You'll need to log out and back in for this to take effect)"
fi

# Check if X server is running (for GUI mode)
if [ -n "$DISPLAY" ]; then
  echo "✅ X server is running (DISPLAY=$DISPLAY)"
  
  # Check if xhost is available
  if command -v xhost &> /dev/null; then
    echo "✅ xhost is available for X server access control"
  else
    echo "⚠️ xhost is not installed, which is needed for GUI mode"
    echo "Install it with: sudo apt-get install x11-xserver-utils"
  fi
else
  echo "⚠️ No X server detected (DISPLAY not set)"
  echo "GUI mode will not work without an X server"
fi

echo
echo "=== Setup Complete ==="
echo "Next steps:"
echo "1. Build the Docker image:   ./build-image.sh"
echo "2. Test the installation:    ./test-chrome.sh"
echo "3. Run Chrome with GUI:      ./run-chrome-gui.sh"
echo