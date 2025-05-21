# Google Chrome Docker Image

This Docker image contains the latest Google Chrome browser running on Ubuntu 20.04. It's designed to be compatible with older Ubuntu hosts (like Ubuntu 16.04).

## Building the Image

To build the Docker image:

```bash
docker build -t chrome-latest .
```

## Running the Container

### Check Chrome Version

```bash
docker run --privileged --rm chrome-latest --version
```

### Run Chrome with Specific URL and Dump DOM

```bash
docker run --privileged --rm chrome-latest --dump-dom https://www.google.com
```

### Take a Screenshot

```bash
docker run --privileged --rm -v $(pwd)/output:/home/chrome/output chrome-latest --screenshot=/home/chrome/output/screenshot.png https://www.google.com
```

### Export a PDF

```bash
docker run --privileged --rm -v $(pwd)/output:/home/chrome/output chrome-latest --print-to-pdf=/home/chrome/output/page.pdf https://www.google.com
```

### Run Chrome with GUI

To run Chrome with a graphical user interface, you need to have an X server running on your host machine and share it with the Docker container:

```bash
# Allow connections from Docker to the X server
xhost +local:docker

# Run Chrome with GUI
docker run --privileged --rm \
  -e DISPLAY=$DISPLAY \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  chrome-latest --gui https://www.google.com

# Revoke X server access when done
xhost -local:docker
```

For convenience, you can use the included script:

```bash
./run-chrome-gui.sh
```

## Features

- Based on Ubuntu 20.04 for better compatibility with older hosts
- Includes the latest stable version of Google Chrome
- Supports both headless mode (default) and GUI mode
- Uses Xvfb to provide a virtual display when needed
- Includes dbus-x11 for D-Bus support
- Pre-configured with all necessary flags for containerized environments

## Modes of Operation

### Headless Mode (Default)

By default, Chrome runs in headless mode, which is ideal for:
- Automated testing
- Web scraping
- PDF generation
- Screenshot capture
- Server environments without a display

### GUI Mode

Use the `--gui` flag to run Chrome with a graphical interface:
- Interactive browsing
- Visual debugging
- Manual testing
- Demonstrations

## Security Considerations

- This image requires the `--privileged` flag to run properly, which gives the container full access to the host's devices
- The `--no-sandbox` and other security-related flags are used to run Chrome in a Docker container
- Due to these security implications, only use this image in trusted environments
- Not recommended for production use cases where security is a primary concern

## Performance Tips

- For better performance, you can mount `/dev/shm` with a larger size:
  ```bash
  docker run --privileged --rm --shm-size=2g chrome-latest https://www.google.com
  ```

## Troubleshooting

If you encounter permission issues when running Docker commands, you may need to:

1. Run Docker commands with sudo:
   ```bash
   sudo docker run --privileged --rm chrome-latest https://www.google.com
   ```

2. Or add your user to the docker group (requires logout/login to take effect):
   ```bash
   sudo usermod -aG docker $USER
   ```

For GUI mode issues:
- Make sure you have an X server running on your host
- Check that you've allowed connections with `xhost +local:docker`
- Verify that your DISPLAY environment variable is set correctly

## Testing

Use the included test script to verify that the container is working correctly:

```bash
./test-chrome.sh
```

This will run several tests to check if Chrome can:
- Report its version
- Take screenshots
- Dump DOM content
- Export PDFs