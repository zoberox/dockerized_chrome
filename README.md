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
docker run --rm chrome-latest
```

### Run Chrome with Specific URL

```bash
docker run --rm chrome-latest https://www.google.com
```

### Run Chrome with Headless Mode and Dump DOM

```bash
docker run --rm chrome-latest --headless --dump-dom https://www.google.com
```

### Take a Screenshot

```bash
docker run --rm -v $(pwd)/output:/home/chrome/output chrome-latest --headless --screenshot=/home/chrome/output/screenshot.png https://www.google.com
```

## Features

- Based on Ubuntu 20.04 for better compatibility with older hosts
- Includes the latest stable version of Google Chrome
- Runs as a non-root user for better security
- Uses Xvfb to provide a virtual display
- Includes dbus-x11 for D-Bus support
- Configured with appropriate flags for containerized environments

## Environment Variables

- `CHROME_FLAGS`: Default Chrome flags set to `--no-sandbox --disable-dev-shm-usage --disable-gpu`

## Security Considerations

- The `--no-sandbox` flag is used to run Chrome in a Docker container. This has security implications, so only use this image in trusted environments.
- For better security in production environments, consider using a more restrictive seccomp profile.

## Performance Tips

- For better performance, you can mount `/dev/shm` with a larger size:
  ```bash
  docker run --rm --shm-size=2g chrome-latest https://www.google.com
  ```

## Troubleshooting

If you encounter permission issues when running Docker commands, you may need to:

1. Run Docker commands with sudo:
   ```bash
   sudo docker run --rm chrome-latest https://www.google.com
   ```

2. Or add your user to the docker group (requires logout/login to take effect):
   ```bash
   sudo usermod -aG docker $USER
   ```