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
docker run --rm chrome-latest $CHROME_FLAGS https://www.google.com
```

### Run Chrome with Custom Flags

```bash
docker run --rm chrome-latest --headless --disable-gpu --dump-dom https://www.google.com
```

## Features

- Based on Ubuntu 20.04 for better compatibility with older hosts
- Includes the latest stable version of Google Chrome
- Runs as a non-root user for better security
- Configured with appropriate flags for containerized environments

## Environment Variables

- `CHROME_FLAGS`: Default Chrome flags set to `--no-sandbox --disable-dev-shm-usage --disable-gpu --headless`

## Notes

- The `--no-sandbox` flag is used to run Chrome in a Docker container. This has security implications, so only use this image in trusted environments.
- For better performance, you can mount `/dev/shm` with a larger size:
  ```bash
  docker run --rm --shm-size=2g chrome-latest $CHROME_FLAGS https://www.google.com
  ```