# R Docker Image

This repository contains a Dockerfile that extends the `rocker/tidyverse` image with additional R packages and LaTeX tools.

## Features

- Based on `rocker/tidyverse`
- Includes additional R packages:
  - formatr
  - ggplot2
  - knitr
  - rmarkdown
  - runit
  - testthat
  - binb
  - linl
  - pinp
  - tint
- Complete LaTeX environment with extra fonts and packages
- Pre-configured R environment for package development and testing

## Usage

To use this image, you can pull it from Docker Hub:

```bash
docker pull [your-dockerhub-username]/[repository-name]
```

## Building Locally

To build the image locally:

```bash
docker build -t [your-tag] .
```

## GitHub Actions

This repository uses GitHub Actions to automatically build and publish the Docker image to Docker Hub. To set this up:

1. Create a Docker Hub account if you don't have one
2. Add the following secrets to your GitHub repository:
   - `DOCKERHUB_USERNAME`: Your Docker Hub username
   - `DOCKERHUB_TOKEN`: Your Docker Hub access token

The image will be automatically built and pushed to Docker Hub when changes are pushed to the main branch. 