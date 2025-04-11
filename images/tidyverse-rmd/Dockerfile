## Emacs, make this -*- mode: sh; -*-

FROM rocker/tidyverse:latest

LABEL org.label-schema.license="MIT" \
      org.label-schema.vcs-url="https://github.com/shalom-lab/r-docker" \
      maintainer="slren"

# Install fonts and other dependencies
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
        latex-cjk-chinese-arphic-gkai00mp \
        wget \
        unzip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install Source Han fonts
RUN mkdir -p /usr/share/fonts/opentype/source-han && \
    cd /usr/share/fonts/opentype/source-han && \
    wget https://github.com/adobe-fonts/source-han-sans/releases/download/2.004R/SourceHanSansCN.zip && \
    wget https://github.com/adobe-fonts/source-han-serif/releases/download/2.002R/SourceHanSerifCN.zip && \
    unzip SourceHanSansCN.zip && \
    unzip SourceHanSerifCN.zip && \
    rm *.zip

# Update font cache
RUN fc-cache -fv

# Install additional R packages
RUN R -e 'install.packages(c("formatr", "runit", "testthat", "binb", "linl", "pinp", "tint", "flexdashboard"), repos="https://cloud.r-project.org/", dependencies=TRUE)'

# Configure R to use Chinese fonts
RUN echo "options(device = function(file, width = 7, height = 7, ...) { \
    grDevices::cairo_pdf(file, width = width, height = height, ...) \
})" >> /usr/local/lib/R/etc/Rprofile.site && \
    echo "options(bitmapType='cairo')" >> /usr/local/lib/R/etc/Rprofile.site

# Create default R Markdown template with Chinese support
RUN mkdir -p /usr/local/lib/R/site-library/rmarkdown/rmd/latex && \
    echo '\documentclass{article}' > /usr/local/lib/R/site-library/rmarkdown/rmd/latex/default.tex && \
    echo '\usepackage{xeCJK}' >> /usr/local/lib/R/site-library/rmarkdown/rmd/latex/default.tex && \
    echo '\usepackage{fontspec}' >> /usr/local/lib/R/site-library/rmarkdown/rmd/latex/default.tex && \
    echo '\setmainfont{Source Han Serif CN}' >> /usr/local/lib/R/site-library/rmarkdown/rmd/latex/default.tex && \
    echo '\setsansfont{Source Han Sans CN}' >> /usr/local/lib/R/site-library/rmarkdown/rmd/latex/default.tex && \
    echo '\setmonofont{Source Han Sans CN}' >> /usr/local/lib/R/site-library/rmarkdown/rmd/latex/default.tex && \
    echo '\setCJKmainfont[BoldFont=Source Han Serif CN]{Source Han Serif CN}' >> /usr/local/lib/R/site-library/rmarkdown/rmd/latex/default.tex && \
    echo '\setCJKsansfont[BoldFont=Source Han Sans CN]{Source Han Sans CN}' >> /usr/local/lib/R/site-library/rmarkdown/rmd/latex/default.tex && \
    echo '\setCJKmonofont{Source Han Sans CN}' >> /usr/local/lib/R/site-library/rmarkdown/rmd/latex/default.tex && \
    echo '\XeTeXlinebreaklocale "zh"' >> /usr/local/lib/R/site-library/rmarkdown/rmd/latex/default.tex && \
    echo '\XeTeXlinebreakskip = 0pt plus 1pt' >> /usr/local/lib/R/site-library/rmarkdown/rmd/latex/default.tex && \
    echo '\begin{document}' >> /usr/local/lib/R/site-library/rmarkdown/rmd/latex/default.tex && \
    echo '\end{document}' >> /usr/local/lib/R/site-library/rmarkdown/rmd/latex/default.tex

RUN echo '---' > /usr/local/lib/R/site-library/rmarkdown/rmd/latex/default-1.17.0.2.tex && \
    echo 'title: "Untitled"' >> /usr/local/lib/R/site-library/rmarkdown/rmd/latex/default-1.17.0.2.tex && \
    echo 'author: "Your Name"' >> /usr/local/lib/R/site-library/rmarkdown/rmd/latex/default-1.17.0.2.tex && \
    echo 'date: "`r format(Sys.time(), '"'"'%Y-%m-%d'"'"')`"' >> /usr/local/lib/R/site-library/rmarkdown/rmd/latex/default-1.17.0.2.tex && \
    echo 'output:' >> /usr/local/lib/R/site-library/rmarkdown/rmd/latex/default-1.17.0.2.tex && \
    echo '  pdf_document:' >> /usr/local/lib/R/site-library/rmarkdown/rmd/latex/default-1.17.0.2.tex && \
    echo '    latex_engine: xelatex' >> /usr/local/lib/R/site-library/rmarkdown/rmd/latex/default-1.17.0.2.tex && \
    echo '    template: default.tex' >> /usr/local/lib/R/site-library/rmarkdown/rmd/latex/default-1.17.0.2.tex && \
    echo '---' >> /usr/local/lib/R/site-library/rmarkdown/rmd/latex/default-1.17.0.2.tex

RUN mkdir -p ~/.R && \
    echo "_R_CHECK_FORCE_SUGGESTS_=FALSE" > ~/.R/check.Renviron && \
    cd /usr/local/bin && \
    ln -s /usr/lib/R/site-library/littler/examples/render.r .

CMD ["bash"] 