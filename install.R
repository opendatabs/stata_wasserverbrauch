# Fixed package versions
packages <- list(
  "tidyverse" = "2.0.0",   
  "openxlsx"  = "4.2.5"    
)

# Ensure 'remotes' package is installed
if (!requireNamespace("remotes", quietly = TRUE)) {
  install.packages("remotes")
}

# Install and load packages without updating to newer versions
for (pkg in names(packages)) {
  target_version <- packages[[pkg]]
  
  if (!requireNamespace(pkg, quietly = TRUE)) {
    message(sprintf("Installing %s version %s ...", pkg, target_version))
    remotes::install_version(pkg, version = target_version, repos = "https://cloud.r-project.org", upgrade = "never")
  } else {
    current_version <- as.character(packageVersion(pkg))
    if (current_version != target_version) {
      message(sprintf("Package %s is version %s – installing required version %s ...", pkg, current_version, target_version))
      remotes::install_version(pkg, version = target_version, repos = "https://cloud.r-project.org", upgrade = "never")
    }
  }
  library(pkg, character.only = TRUE)
}
message("✔️ Alle Pakete installiert und geladen.")

