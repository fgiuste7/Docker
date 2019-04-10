# 12/26/2018 (FG)
# fgiuste/jupyter:nopswd
#------------------------------------------------
# Inherits: phusion/baseimage:0.10.2            |
# https://github.com/phusion/baseimage-docker   |
# From Ubuntu 16.04.5                           |
#------------------------------------------------
FROM fgiuste/base:base

#----------------------------
# Install Miniconda3: 4.5.11:
#----------------------------
USER root
ENV CONDA_DIR=/opt/conda \
    PATH=/opt/conda/bin:$PATH
RUN echo "Downloading Miniconda installer ..." \
    && miniconda_installer=/tmp/miniconda.sh \
    && curl -sSL --retry 5 -o $miniconda_installer https://repo.continuum.io/miniconda/Miniconda3-4.5.11-Linux-x86_64.sh \
    && /bin/bash $miniconda_installer -b -p $CONDA_DIR \
    && rm -f $miniconda_installer \
    && conda config --system --prepend channels conda-forge \
    && conda config --system --set auto_update_conda false \
    && conda config --system --set show_channel_urls true \
    && conda clean -tipsy && sync

#---------------
# Conda Install:
#---------------
USER root
RUN conda install -y traits \
                     jupyter \
                     pandas \
                     matplotlib \
                     nbformat \
                     nb_conda \
                     ipywidgets \
                     scipy \
                     dask \
                     plotly \
                     h5py \
                     pytables \
                     zarr \
    && sync && conda clean -tipsy \
    && sync

RUN bash -c "rm -rf /opt/conda/pkgs/*"

#------------------------------
# Allow mainuser conda install:
#------------------------------
USER root
RUN chmod -R 777 /opt/conda

#------------------------
# Jupyter Notebook setup:
#------------------------
USER root
# Set ip default to localhost:
RUN mkdir -p /home/mainuser/.jupyter \
    && echo c.NotebookApp.ip = \"0.0.0.0\" > /home/mainuser/.jupyter/jupyter_notebook_config.py

#-----------------------------------------
# Login as user root to login as mainuser:
#-----------------------------------------
USER root