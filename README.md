# ![Logo] TirsvadCLI Docker image — Debian 13 + .NET 10

Lightweight `debian:13-slim` image with the .NET 10 SDK installed. Suitable as a base for CLI tooling that requires .NET 10.

## ⚡ Quick start

Prerequisites:
- Docker
- Docker Compose (v2+)

Build and run locally:

```bash
# Build and start using docker compose
docker compose build --no-cache --progress=plain
docker compose up -d

# Or run directly
docker run -it --rm tirsvad/tirsvadcli_dotnet10_debian13:latest bash
```

## 🛠️ Troubleshooting

If the build fails, run with plain logs to see diagnostics:

```bash
docker compose build --no-cache --progress=plain
```

Common issues:
- Network/download failures when adding Microsoft packages — retry the build.
- Missing native dependencies — check the `apt` step output in the Dockerfile.

## 📁 Files of interest
- `Dockerfile` — builds Debian 13 + .NET 10 image
- `docker-compose.yml` — minimal compose file for local development

## 📜 License
This project is licensed under the [AGPL License].

<!-- Links -->
[Logo]: https://raw.githubusercontent.com/TirsvadCLI/Logo/main/images/logo/32x32/logo.png
[AGPL License]: ./LICENSE "GNU AGPLv3 License"
