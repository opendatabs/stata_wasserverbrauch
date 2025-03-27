# Renku-ready Dockerfile (vollständig, nur R, kein Python Notebook)

# Verwende offizielles Renku-Basisimage mit R und RStudio
FROM renku/renkulab-r:4.3.1-0.25.0

# Argument für dynamische Renku-Version (von Template gesetzt)
ARG RENKU_VERSION={{ __renku_version__ | default("2.7.0") }}

# Systempakete installieren (z. B. für tidyverse, openxlsx)
RUN apt-get update && apt-get install -y \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    && rm -rf /var/lib/apt/lists/*


# Renku CLI installieren oder updaten

RUN if [ -n "$RENKU_VERSION" ] ; then \
        source .renku/venv/bin/activate ; \
        currentversion=$(renku --version) ; \
        if [ "$RENKU_VERSION" != "$currentversion" ] ; then \
            pip uninstall renku -y ; \
            gitversion=$(echo "$RENKU_VERSION" | sed -n "s/^[[:digit:]]\+\.[[:digit:]]\+\.[[:digit:]]\+\(rc[[:digit:]]\+\)*\(\.dev[[:digit:]]\+\)*\(+g\([a-f0-9]\+\)\)*\(+dirty\)*$/\4/p") ; \
            if [ -n "$gitversion" ] ; then \
                pip install --no-cache-dir --force "git+https://github.com/SwissDataScienceCenter/renku-python.git@$gitversion" ;\
            else \
                pip install --no-cache-dir --force renku==${RENKU_VERSION} ;\
            fi \
        fi \
    fi


# R-Installationsskript kopieren und ausführen

COPY install.R ./
RUN R -f install.R

# Projektdateien kopieren

COPY . .
