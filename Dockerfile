# Verwende offizielles Renku-Basisimage mit R und RStudio
FROM renku/renkulab-r:4.3.1-0.25.0

# R-Installationsskript kopieren und ausführen
COPY install.R ./
RUN R -f install.R
