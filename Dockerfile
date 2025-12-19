FROM debian:13.2-slim

# Install required OS packages
RUN apt-get update \
 && apt-get install -y --no-install-recommends \
    ca-certificates \
    wget \
 && rm -rf /var/lib/apt/lists/*

# Install .NET via Microsoft APT repository (deb package registers the repo and GPG key)
ENV DOTNET_ROOT=/usr/share/dotnet \
    DOTNET_CLI_TELEMETRY_OPTOUT=1

RUN set -eux; \
    wget https://packages.microsoft.com/config/debian/13/packages-microsoft-prod.deb -O /tmp/packages-microsoft-prod.deb; \
    dpkg -i /tmp/packages-microsoft-prod.deb; \
    rm /tmp/packages-microsoft-prod.deb; \
    apt-get update; \
    apt-get install -y --no-install-recommends dotnet-sdk-10.0; \
    rm -rf /var/lib/apt/lists/*

# Verify install (will show version when building)
RUN dotnet --info

WORKDIR /app

CMD ["bash"]
