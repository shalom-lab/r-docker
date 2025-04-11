## Emacs, make this -*- mode: sh; -*-

FROM rocker/tidyverse:latest

LABEL org.label-schema.license="GPL-2.0" \
      org.label-schema.vcs-url="https://github.com/rocker-org/rocker" \
      maintainer="Dirk Eddelbuettel <edd@debian.org>"

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        ghostscript \
        lmodern \
        qpdf \
        texinfo \
        texlive-fonts-extra \
        texlive-fonts-recommended \
        texlive-latex-extra \
        texlive-latex-recommended \
        texlive-luatex \
        texlive-plain-generic \
        texlive-science \
        texlive-xetex && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install additional R packages
RUN install2.r --error --skipinstalled \
    formatr \
    runit \
    testthat \
    binb \
    linl \
    pinp \
    tint \
    flexdashboard && \
    rm -rf /tmp/downloaded_packages

RUN mkdir -p ~/.R && \
    echo "_R_CHECK_FORCE_SUGGESTS_=FALSE" > ~/.R/check.Renviron && \
    cd /usr/local/bin && \
    ln -s /usr/lib/R/site-library/littler/examples/render.r .

CMD ["bash"] 