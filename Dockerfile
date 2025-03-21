FROM rocker/r-ver:4.2.3

RUN apt-get update && apt-get install -y \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    && rm -rf /var/lib/apt/lists/*

RUN R -e "install.packages('remotes', repos='https://cloud.r-project.org')"
RUN R -e \"remotes::install_version('tidyverse', version='2.0.0', repos='https://cloud.r-project.org')\"
RUN R -e \"remotes::install_version('openxlsx', version='4.2.8', repos='https://cloud.r-project.org')\"

WORKDIR /home/wasserverbrauch

COPY . .


CMD ["Rscript", "scripts/Wasserverbrauch.R"]


