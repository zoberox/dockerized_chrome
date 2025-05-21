FROM ubuntu:20.04

# Avoid prompts from apt
ENV DEBIAN_FRONTEND=noninteractive

# Set up locale
RUN apt-get update && apt-get install -y locales && \
    locale-gen en_US.UTF-8 && \
    update-locale LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8

# Install dependencies
RUN apt-get update && apt-get install -y \
    wget \
    gnupg2 \
    apt-transport-https \
    ca-certificates \
    fonts-liberation \
    libasound2 \
    libatk-bridge2.0-0 \
    libatk1.0-0 \
    libatspi2.0-0 \
    libcups2 \
    libdbus-1-3 \
    libdrm2 \
    libgbm1 \
    libgtk-3-0 \
    libnspr4 \
    libnss3 \
    libpango-1.0-0 \
    libx11-6 \
    libxcb1 \
    libxcomposite1 \
    libxdamage1 \
    libxext6 \
    libxfixes3 \
    libxkbcommon0 \
    libxrandr2 \
    xdg-utils \
    dbus-x11 \
    xvfb \
    --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

# Add Google Chrome repository
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - && \
    echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list

# Install Google Chrome
RUN apt-get update && apt-get install -y \
    google-chrome-stable \
    --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

# Create a wrapper script to run Chrome with Xvfb
RUN echo '#!/bin/bash\n\
Xvfb :99 -screen 0 1280x1024x24 -ac +extension GLX +render -noreset &\n\
export DISPLAY=:99\n\
# Wait for Xvfb to start\n\
sleep 1\n\
# Run Chrome with all sandbox and namespace features disabled\n\
google-chrome-stable \
--no-sandbox \
--disable-setuid-sandbox \
--disable-dev-shm-usage \
--disable-accelerated-2d-canvas \
--disable-gpu \
--disable-software-rasterizer \
--disable-background-networking \
--disable-default-apps \
--disable-extensions \
--disable-sync \
--disable-translate \
--headless \
"$@"\n' > /usr/local/bin/chrome-launcher.sh && \
    chmod +x /usr/local/bin/chrome-launcher.sh

# Create a non-root user to run Chrome
RUN groupadd -r chrome && useradd -r -g chrome -G audio,video chrome \
    && mkdir -p /home/chrome && chown -R chrome:chrome /home/chrome

# Switch to root for entrypoint (to handle permissions better)
WORKDIR /home/chrome

# Set the entrypoint to run Chrome with Xvfb
ENTRYPOINT ["/usr/local/bin/chrome-launcher.sh"]
CMD ["--version"]