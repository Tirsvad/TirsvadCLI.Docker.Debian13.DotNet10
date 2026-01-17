FROM debian:13-slim

# Install required OS packages
RUN apt-get update \
    && apt-get upgrade -y

RUN apt-get install -y --no-install-recommends \
        ca-certificates \
        wget \
        curl \
    && rm -rf /var/lib/apt/lists/*

# Install .NET via Microsoft APT repository (deb package registers the repo and GPG key)
ENV DOTNET_ROOT=/usr/share/dotnet \
    DOTNET_CLI_TELEMETRY_OPTOUT=1

RUN set -eux; \
    wget https://packages.microsoft.com/config/debian/13/packages-microsoft-prod.deb -O packages-microsoft-prod.deb; \
    dpkg -i packages-microsoft-prod.deb; \
    rm packages-microsoft-prod.deb

RUN set -eux; \
    apt-get update; \
    apt-get install -y dotnet-sdk-10.0

RUN dotnet workload install wasm-tools

# Install dotnet coverage tool
RUN dotnet tool install --global dotnet-coverage --version 18.3.2
RUN dotnet tool install --global dotnet-reportgenerator-globaltool --version 5.5.1
#RUN dotnet workload install wasm-tools --skip-manifest-update

# Ensure global dotnet tools for root are on PATH for non-login shells
ENV PATH="$PATH:/root/.dotnet/tools"
ENV DOTNET_RUNNING_IN_CONTAINER="true"

# Export $HOME/.dotnet/tools for all users (login shells will source /etc/profile.d)
RUN printf 'export PATH="$PATH:$HOME/.dotnet/tools"\n' > /etc/profile.d/dotnet-tools.sh \
    && chmod 0755 /etc/profile.d/dotnet-tools.sh

WORKDIR /app

CMD ["bash"]
