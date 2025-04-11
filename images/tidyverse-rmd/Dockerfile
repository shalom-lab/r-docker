## Emacs, make this -*- mode: sh; -*-

FROM rocker/tidyverse:latest

LABEL org.label-schema.license="MIT" \
      org.label-schema.vcs-url="https://github.com/shalom-lab/r-docker" \
      maintainer="slren"

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
        texlive-xetex \
        fonts-noto-cjk \
        fonts-noto-cjk-extra \
        fonts-wqy-microhei \
        fonts-wqy-zenhei \
        ttf-mscorefonts-installer \
        latex-cjk-all \
        latex-cjk-chinese \
        latex-cjk-chinese-arphic-bkai00mp \
        latex-cjk-chinese-arphic-gbsn00lp \
        latex-cjk-chinese-arphic-gkai00mp && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install additional R packages
RUN R -e 'install.packages(c("formatr", "runit", "testthat", "binb", "linl", "pinp", "tint", "flexdashboard"), repos="https://cloud.r-project.org/", dependencies=TRUE)'

# Configure R to use Chinese fonts
RUN echo "options(device = function(file, width = 7, height = 7, ...) { \
    grDevices::cairo_pdf(file, width = width, height = height, ...) \
})" >> /usr/local/lib/R/etc/Rprofile.site && \
    echo "options(bitmapType='cairo')" >> /usr/local/lib/R/etc/Rprofile.site

# Create default R Markdown template with Chinese support
RUN mkdir -p /usr/local/lib/R/site-library/rmarkdown/rmd/latex && \
    printf '\\documentclass{article}\n\\usepackage{xeCJK}\n\\setCJKmainfont{Noto Serif CJK SC}\n\\setCJKsansfont{Noto Sans CJK SC}\n\\setCJKmonofont{Noto Sans Mono CJK SC}\n\\XeTeXlinebreaklocale "zh"\n\\XeTeXlinebreakskip = 0pt plus 1pt\n\\begin{document}\n\\end{document}' > /usr/local/lib/R/site-library/rmarkdown/rmd/latex/default.tex && \
    printf '---\ntitle: "Untitled"\nauthor: "Your Name"\ndate: "`r format(Sys.time(), \"%%Y-%%m-%%d\")`"\noutput:\n  pdf_document:\n    latex_engine: xelatex\n    template: default.tex\n---' > /usr/local/lib/R/site-library/rmarkdown/rmd/latex/default-1.17.0.2.tex

RUN mkdir -p ~/.R && \
    echo "_R_CHECK_FORCE_SUGGESTS_=FALSE" > ~/.R/check.Renviron && \
    cd /usr/local/bin && \
    ln -s /usr/lib/R/site-library/littler/examples/render.r .

CMD ["bash"] 