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

#----------------------------
# Install common dependencies
#----------------------------
ENV LANG="en_US.UTF-8" \
LC_ALL="C.UTF-8"

RUN apt-get update -qq && apt-get install -yq --no-install-recommends \
       apt-utils ca-certificates curl locales unzip sudo gnupg dirmngr screen bzip2 \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && localedef --force --inputfile=en_US --charmap=UTF-8 C.UTF-8 \
    && chmod 777 /opt && chmod a+s /opt \
    && chmod -R 777 /home && chmod a+s /home \
    && apt-get update -qq


#---------------------------
# Create Default Entrypoint:
#---------------------------
ENV ND_ENTRYPOINT="/home/startup.sh"

RUN if [ ! -f "$ND_ENTRYPOINT" ]; then \
    echo '#!/usr/bin/env bash' >> $ND_ENTRYPOINT \
    && echo 'set +x' >> $ND_ENTRYPOINT \
    && echo 'if [ -z "$*" ]; then /usr/bin/env bash; else $*; fi' >> $ND_ENTRYPOINT; \
    fi


ENTRYPOINT ["/sbin/my_init", "--", "setuser", "neuro", "/home/startup.sh"]
RUN sed -i '$isource /etc/fsl/fsl.sh' $ND_ENTRYPOINT


#----------------------------------------------------------
# NeuroDebian Keys
# http://neuro.debian.net/install_pkg.html?p=ants
# Neurodebian:
# https://github.com/neurodebian/dockerfiles/blob/88af27888a5aee76924c3b6840fc47f9cd8f63cb/dockerfiles/xenial-non-free/Dockerfile
#----------------------------------------------------------
# RUN wget -O- http://neuro.debian.net/lists/xenial.us-tn.full | sudo tee /etc/apt/sources.list.d/neurodebian.sources.list
# RUN apt-key adv --recv-keys --keyserver hkp://pool.sks-keyservers.net:80 0xA5D32F012649A5A9
# https://bugs.debian.org/830696 (apt uses gpgv by default in newer releases, rather than gpg)

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

#---------------------
# NeuroDebian Packages
#---------------------
RUN apt-get update -qq \
    && apt-get install -y -q --no-install-recommends convert3d \
                                                     ants \
                                                     fsl \
                                                     fsl-atlases \
                                                     tree \
                                                     vim \
                                                     emacs-nox \
                                                     nano \
                                                     ncdu \
                                                     graphviz \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


#-----------------------
# Create new user: neuro
#-----------------------
RUN useradd --no-user-group --create-home --shell /bin/bash neuro
USER neuro

ENV PROFILE='/home/neuro/.profile'
RUN echo "$isource /etc/fsl/fsl.sh" >> $PROFILE
RUN echo "alias ls='ls -lha --color=auto' " >> $PROFILE
RUN echo "alias rm='rm -i' " >> $PROFILE

#---------------------------
# Install Miniconda3: 4.3.31
#---------------------------
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
    && conda clean -tipsy && sync

#-------------------------
# Conda Install
#-------------------------
RUN conda install -y pytest \
                     jupyter \
                     traits \
                     pandas \
                     dask \
                     matplotlib \
                     scikit-learn \
                     scikit-image \
                     seaborn \
                     nbformat \
                     nb_conda \
                     ipywidgets \
                     plotly \
                     dash \
                     dash-renderer \
                     dash-html-components \
                     dash-core-components \
                     nibabel \
                     scipy \
                     graphviz \
                     python-graphviz \
                     networkx \
                     pydot \
                     dask \
                     h5py \
                     pytables \
                     zarr \
    && sync && conda clean -tipsy && sync \
    && pip install --no-cache-dir https://github.com/nipy/nipype/tarball/master \
                                  https://github.com/INCF/pybids/tarball/master \
                                  nilearn \
                                  datalad[full] \
                                  nipy \
                                  duecredit \
    && sync

RUN bash -c "rm -rf /opt/conda/pkgs/*"

#---------------
# Install girder
#---------------
USER root
RUN pip install keras girder girder-client

#------------------
# Install niwidgets
#------------------
USER root
RUN pip install --no-cache-dir niwidgets nilearn

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
RUN chmod -R 777 /etc/fsl
RUN chmod -R 777 /home/neuro
RUN mkdir /data && chmod -R 777 /data
RUN mkdir /output && chmod -R 777 /output
RUN chmod 777 /home/startup.sh

RUN mkdir -p /code/scripts \
    && mkdir -p /code/notebooks \
    && chmod -R 777 /code

RUN mkdir -p /app \
    && chmod -R 777 /app

#----------------------------------------
# Add ANTS directory to PATH and ANTSPATH
# Switch to user neuro
#----------------------------------------
USER neuro

ENV PATH=$PATH:/usr/lib/ants/
ENV ANTSPATH=/usr/lib/ants/

#--------------------------------------
# Make bash the default shell for neuro
#--------------------------------------
USER root
RUN chsh -s /bin/bash neuro

#----------------------------------
# Define ROOT password: FOR TESTING
#----------------------------------
RUN echo "root:Docker!" | chpasswd

#----------------------------
# RWB Specific:
# Add scripts to final image:
#----------------------------
USER root
RUN mkdir -p /code/RWB \
    && chmod -R 777 /code

USER neuro
ADD runSupervisor.sh /code/RWB/runSupervisor.sh
ADD Supervisor_RWB.py /code/RWB/Supervisor_RWB.py
ADD RWB_STEP1_fxns.py /code/RWB/RWB_STEP1_fxns.py
ADD RWB_STEP2_fxns.py /code/RWB/RWB_STEP2_fxns.py
ADD RWB_STEP3_fxns.py /code/RWB/RWB_STEP3_fxns.py

#-------------------------------------
# RWB Specific:
# Run Supervisor_RWB.py in ENTRYPOINT:
#-------------------------------------
# Add ENV variables to pass to runSupervisor.sh ?
RUN echo /code/RWB/runSupervisor.sh >> $ND_ENTRYPOINT

#---------------------
# Login as user: neuro
#---------------------
USER neuro
ENV ls='ls -lh --color=auto'
WORKDIR /home/neuro

USER root
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
