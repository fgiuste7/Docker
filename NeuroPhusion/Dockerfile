# 8/27/2018 (FG)
# 
# To Build Docker Image:
# cd ${Dockerfile_Directory}
# docker build --tag ${image_name} .

#----------------------------------------------------------
# Install phusion/baseimage:0.10.2
# https://github.com/phusion/baseimage-docker
# From Ubuntu 16.04.5 LTS
#----------------------------------------------------------
FROM phusion/baseimage:0.10.2

#---------------------------------------------
# Install common dependencies (+screen +tree):
#---------------------------------------------
USER root
ENV LANG="en_US.UTF-8" \
LC_ALL="C.UTF-8"

RUN apt-get update -qq && apt-get install -yq --no-install-recommends \
       apt-utils \
       ca-certificates \
       curl \
       locales \
       unzip \
       sudo \
       gnupg \
       dirmngr \
       screen \
       tree \
       bzip2 \
    && apt-get update -qq \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && localedef --force --inputfile=en_US --charmap=UTF-8 C.UTF-8 

#---------------------------------------
# Create Default Entrypoint to load FSL:
#---------------------------------------
USER root
ENV ND_ENTRYPOINT="/home/startup.sh"

RUN echo '#!/usr/bin/env bash' >> $ND_ENTRYPOINT \
&& echo 'set +x' >> $ND_ENTRYPOINT \
&& echo 'if [ -z "$*" ]; then /usr/bin/env bash; else $*; fi' >> $ND_ENTRYPOINT;

ENTRYPOINT ["/sbin/my_init", "--", "setuser", "neuro", "/home/startup.sh"]
RUN sed -i '$isource /etc/fsl/fsl.sh' $ND_ENTRYPOINT

#----------------------------------------------------------
# NeuroDebian Keys
# http://neuro.debian.net/install_pkg.html?p=ants
# Neurodebian:
# https://github.com/neurodebian/dockerfiles/blob/88af27888a5aee76924c3b6840fc47f9cd8f63cb/dockerfiles/xenial-non-free/Dockerfile
#----------------------------------------------------------
USER root
RUN set -x \
    && export GNUPGHOME="$(mktemp -d)" \
    && gpg --keyserver ha.pool.sks-keyservers.net --recv-keys DD95CC430502E37EF840ACEEA5D32F012649A5A9 \
    && gpg --export DD95CC430502E37EF840ACEEA5D32F012649A5A9 > /etc/apt/trusted.gpg.d/neurodebian.gpg \
    && rm -rf "$GNUPGHOME" \
    && apt-key list | grep neurodebian

RUN { \
    echo 'deb http://neuro.debian.net/debian xenial main'; \
    echo 'deb http://neuro.debian.net/debian data main'; \
    echo '#deb-src http://neuro.debian.net/debian-devel xenial main'; \
} > /etc/apt/sources.list.d/neurodebian.sources.list

RUN sed -i -e 's,main *$,main contrib non-free,g' /etc/apt/sources.list.d/neurodebian.sources.list; grep -q 'deb .* multiverse$' /etc/apt/sources.list || sed -i -e 's,universe *$,universe multiverse,g' /etc/apt/sources.list

#-----------------------------------
# NeuroDebian Packages (+ANTS +FSL):
#-----------------------------------
USER root
RUN apt-get update -qq \
    && apt-get install -y -q --no-install-recommends convert3d \
                                                     ants \
                                                     fsl \
                                                     fsl-atlases \
                                                     ncdu \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

#-----------------------------------------------
# Install Text Editors (+subl +vim +nano +less):
#-----------------------------------------------
USER root
RUN apt-get update -qq \
    && apt-get install -y -q --no-install-recommends vim \
                                                     nano \
                                                     less \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

#-----------------------
# Create new user: neuro
#-----------------------
USER root
RUN useradd --no-user-group --create-home --shell /bin/bash neuro

#---------------------------
# Install Miniconda3: 4.3.31
#---------------------------
USER root
ENV CONDA_DIR=/opt/conda \
    PATH=/opt/conda/bin:$PATH
RUN echo "Downloading Miniconda installer ..." \
    && miniconda_installer=/tmp/miniconda.sh \
    && curl -sSL --retry 5 -o $miniconda_installer https://repo.continuum.io/miniconda/Miniconda3-4.3.31-Linux-x86_64.sh \
    && /bin/bash $miniconda_installer -b -p $CONDA_DIR \
    && rm -f $miniconda_installer \
    && conda config --system --prepend channels conda-forge \
    && conda config --system --set auto_update_conda false \
    && conda config --system --set show_channel_urls true \
    && conda clean -tipsy && sync \
    && chmod 777 /opt && chmod a+s /opt \

#---------------
# Conda Install:
#---------------
USER root
RUN conda install -y jupyter \
                     pandas \
                     dask \
                     matplotlib \
                     nbformat \
                     nb_conda \
                     ipywidgets \
                     plotly \
                     nibabel \
                     scipy \
                     graphviz \
                     python-graphviz \
                     networkx \
                     pydot \
                     h5py \
                     pytables \
                     zarr \
    && sync && conda clean -tipsy \
    && sync

RUN pip install --no-cache-dir \
                    https://github.com/nipy/nipype/tarball/master \
                    https://github.com/INCF/pybids/tarball/master \
                    datalad[full] \
                    nipy \
                    duecredit \
    && sync

RUN bash -c "rm -rf /opt/conda/pkgs/*"

#-----------------------
# Jupyter Noteook setup:
#-----------------------
USER root
# BASH: Allows Jupyter to run:
RUN mkdir -p /home/neuro/.jupyter \
    && echo c.NotebookApp.ip = \"0.0.0.0\" > /home/neuro/.jupyter/jupyter_notebook_config.py

# BASH: Set notebook password:
RUN echo "{\"NotebookApp\": \
    { \"password\": \"sha1:317d49d226c9:09f54bfd5868c8897e261a281fa9b7fea8904c5d\" } } \
    " >> /home/neuro/.jupyter/jupyter_notebook_config.json

#-----------------------------------------
# Set Directory Structure and Permissions:
#-----------------------------------------
USER root
RUN chmod -R 777 /home && chmod a+s /home
RUN chmod -R 777 /etc/fsl
RUN mkdir /data && chmod -R 777 /data
RUN mkdir /output && chmod -R 777 /output
RUN chmod 777 /home/startup.sh

RUN mkdir -p /code/scripts \
    && mkdir -p /code/notebooks \
    && chmod -R 777 /code

RUN mkdir -p /app && chmod -R 777 /app

#----------------------------------------
# Add ANTS directory to PATH and ANTSPATH
#----------------------------------------
USER neuro
ENV PATH=$PATH:/usr/lib/ants/
ENV ANTSPATH=/usr/lib/ants/

#----------------------------------
# Define ROOT password: FOR TESTING
#----------------------------------
USER root
RUN echo "root:Docker!" | chpasswd

#---------------------
# Login as user: neuro
#---------------------
USER root
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

USER neuro
WORKDIR /home/neuro