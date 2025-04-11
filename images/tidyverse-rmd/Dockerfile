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
    wget https://github.com/adobe-fonts/source-han-serif/releases/download/2.002R/SourceHanSerifSC.zip && \
    wget https://github.com/adobe-fonts/source-han-sans/releases/download/2.004R/SourceHanSansSC.zip && \
    unzip SourceHanSerifSC.zip && \
    unzip SourceHanSansSC.zip && \
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
    cat << 'EOL' > /usr/local/lib/R/site-library/rmarkdown/rmd/latex/default.tex
        \documentclass{article}
        \usepackage{xeCJK}
        \usepackage{fontspec}
        \setmainfont{Source Han Serif SC}
        \setsansfont{Source Han Sans SC}
        \setmonofont{Source Han Sans SC}
        \setCJKmainfont[BoldFont=Source Han Serif SC Bold]{Source Han Serif SC}
        \setCJKsansfont[BoldFont=Source Han Sans SC Bold]{Source Han Sans SC}
        \setCJKmonofont{Source Han Sans SC}
        \XeTeXlinebreaklocale "zh"
        \XeTeXlinebreakskip = 0pt plus 1pt
        \begin{document}
        \end{document}
EOL

RUN cat << 'EOL' > /usr/local/lib/R/site-library/rmarkdown/rmd/latex/default-1.17.0.2.tex
        ---
        title: "Untitled"
        author: "Your Name"
        date: "`r format(Sys.time(), '%Y-%m-%d')`"
        output:
          pdf_document:
            latex_engine: xelatex
            template: default.tex
        ---
EOL

RUN mkdir -p ~/.R && \
    echo "_R_CHECK_FORCE_SUGGESTS_=FALSE" > ~/.R/check.Renviron && \
    cd /usr/local/bin && \
    cat > /usr/local/lib/R/site-library/rmarkdown/rmd/latex/default.tex << 'EOL'
\documentclass{article}
\usepackage{xeCJK}
\usepackage{fontspec}
\setmainfont{Source Han Serif SC}
\setsansfont{Source Han Sans SC}
\setmonofont{Source Han Sans SC}
\setCJKmainfont[BoldFont=Source Han Serif SC Bold]{Source Han Serif SC}
\setCJKsansfont[BoldFont=Source Han Sans SC Bold]{Source Han Sans SC}
\setCJKmonofont{Source Han Sans SC}
\XeTeXlinebreaklocale "zh"
\XeTeXlinebreakskip = 0pt plus 1pt
\begin{document}
\end{document}
EOL

RUN cat > /usr/local/lib/R/site-library/rmarkdown/rmd/latex/default-1.17.0.2.tex << 'EOL'
---
title: "Untitled"
author: "Your Name"
date: "`r format(Sys.time(), '%Y-%m-%d')`"
output:
  pdf_document:
    latex_engine: xelatex
    template: default.tex
---
EOL

RUN mkdir -p ~/.R && \
    echo "_R_CHECK_FORCE_SUGGESTS_=FALSE" > ~/.R/check.Renviron && \
    cd /usr/local/bin && \
    ln -s /usr/lib/R/site-library/littler/examples/render.r .

CMD ["bash"] 