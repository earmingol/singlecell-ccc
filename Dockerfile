# Copyright (c) Jupyter Development Team.
# Distributed under the terms of the Modified BSD License.
ARG BASE_CONTAINER=jupyter/minimal-notebook:4d9c9bd9ced0
FROM $BASE_CONTAINER

USER root

# R pre-requisites
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    fonts-dejavu \
    unixodbc \
    unixodbc-dev \
    r-cran-rodbc \
    gfortran \
    gcc \
    libhdf5-dev && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Fix for devtools https://github.com/conda-forge/r-devtools-feedstock/issues/4
RUN ln -s /bin/tar /bin/gtar

USER $NB_UID

# R packages
RUN conda install --quiet --yes \
    'r-base=4.0.3' \
    'r-caret=6.*' \
    'r-crayon=1.4*' \
    'r-devtools=2.3*' \
    'r-forecast=8.14*' \
    'r-hexbin=1.28*' \
    'r-htmltools=0.5*' \
    'r-htmlwidgets=1.5*' \
    'r-irkernel=1.1*' \
    'r-nycflights13=1.0*' \
    'r-randomforest=4.6*' \
    'r-rcurl=1.98*' \
    'r-rmarkdown=2.7*' \
    'r-rodbc=1.3*' \
    'r-rsqlite=2.2*' \
    'r-shiny=1.6*' \
    'r-tidyverse=1.3*' \
    'unixodbc=2.3.*' \
    'r-tidymodels=0.1*' \
    'umap-learn' \
    'r-cairo' \
    'r-systemfonts' \
    'r-magrittr' \
    'r-dplyr' \
    'r-seurat=4.0.1' \

    && \
    conda clean --all -f -y && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"

# Install e1071 R package (dependency of the caret R package)
RUN conda install --quiet --yes r-e1071


# Install other packages
USER root
COPY packages.r /root/packages.r
RUN Rscript /root/packages.r

# Install cell2cell
USER $NB_UID
RUN pip install cell2cell scanpy
RUN conda install --quiet --yes \
    'ipywidgets' \
    && \
    conda clean --all -f -y && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"
RUN jupyter nbextension enable --py widgetsnbextension