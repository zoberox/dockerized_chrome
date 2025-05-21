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

## Features

- Based on Ubuntu 20.04 for better compatibility with older hosts
- Includes the latest stable version of Google Chrome
- Uses Xvfb to provide a virtual display
- Includes dbus-x11 for D-Bus support
- Pre-configured with all necessary flags for containerized environments
- Headless mode enabled by default

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