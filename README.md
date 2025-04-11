# 🐳 R Docker Images Collection

A curated collection of R-based Docker images for data science and document processing.

## 📦 Available Images

| Image | Description | Status |
|-------|-------------|--------|
| [slren/tidyverse-rmd](images/tidyverse-rmd) | R Markdown and LaTeX environment based on rocker/tidyverse | [![Docker Hub](https://img.shields.io/docker/pulls/slren/tidyverse-rmd.svg)](https://hub.docker.com/r/slren/tidyverse-rmd) |

## 🔨 Building Images

```bash
# For tidyverse-rmd
cd images/tidyverse-rmd
docker build -t slren/tidyverse-rmd .
```

## ⚡ GitHub Actions

Images are automatically built and published to Docker Hub via GitHub Actions. To set up:

1. Add these secrets to your GitHub repository:
   - `DOCKERHUB_USERNAME`: Your Docker Hub username
   - `DOCKERHUB_TOKEN`: Your Docker Hub access token

## ⚖️ License

MIT 