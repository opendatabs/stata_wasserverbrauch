FROM rocker/r-ver:4.2.3

# Installiere Systemabhängigkeiten
RUN apt-get update && apt-get install -y \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    && rm -rf /var/lib/apt/lists/*

# Installiere 'remotes', das für install.R benötigt wird
RUN R -e "install.packages('remotes', repos='https://cloud.r-project.org')"

# Setze Arbeitsverzeichnis
# WORKDIR /home/wasserverbrauch

# Kopiere alle Projektdateien (inkl. install.R) in den Container
COPY . .

# Führe install.R aus
RUN Rscript install.R

# Standard-Startbefehl: Öffnet Bash (für interaktive Renku-Sessions)
CMD ["bash"]
