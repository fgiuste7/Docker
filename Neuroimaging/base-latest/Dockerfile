# 5/17/2019 (FG)
# Felipe Giuste
# Neuroimaging Image
# fgiuste/neuroimaging:latest

FROM ubuntu:18.04


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


#----------------------------------------------------------
# NeuroDebian Keys
# http://neuro.debian.net/install_pkg.html?p=ants
# Neurodebian:
# https://github.com/neurodebian/dockerfiles/blob/88af27888a5aee76924c3b6840fc47f9cd8f63cb/dockerfiles/xenial-non-free/Dockerfile
#----------------------------------------------------------
RUN set -x \
    && export GNUPGHOME="$(mktemp -d)" \
    && gpg --keyserver ha.pool.sks-keyservers.net --recv-keys DD95CC430502E37EF840ACEEA5D32F012649A5A9 \
    && gpg --export DD95CC430502E37EF840ACEEA5D32F012649A5A9 > /etc/apt/trusted.gpg.d/neurodebian.gpg \
    && rm -rf "$GNUPGHOME" \
    && apt-key list | grep neurodebian

RUN { \
    echo 'deb http://neuro.debian.net/debian bionic main'; \
    echo 'deb http://neuro.debian.net/debian data main'; \
    echo '#deb-src http://neuro.debian.net/debian-devel bionic main'; \
} > /etc/apt/sources.list.d/neurodebian.sources.list

RUN sed -i -e 's,main *$,main contrib non-free,g' /etc/apt/sources.list.d/neurodebian.sources.list; grep -q 'deb .* multiverse$' /etc/apt/sources.list || sed -i -e 's,universe *$,universe multiverse,g' /etc/apt/sources.list


#--------------------------
# Create Default Entrypoint
#--------------------------
USER root

ENTRYPOINT ["/home/startup.sh"]
ENV ENTRYPOINT="/home/startup.sh"

RUN if [ ! -f "$ENTRYPOINT" ]; then \
    echo '#!/usr/bin/env bash' >> $ENTRYPOINT \
    && echo 'set +x' >> $ENTRYPOINT \
    && echo 'if [ -z "$*" ]; then /usr/bin/env bash; else $*; fi' >> $ENTRYPOINT; \
    fi


#---------------------
# NeuroDebian Packages
#---------------------
USER root

RUN DEBIAN_FRONTEND=noninteractive apt-get update -qq \
    && apt-get install -y -q --no-install-recommends convert3d \
                                                     ants \
                                                     fsl-complete \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


#--------------
# Misc Packages
#--------------
USER root

RUN apt-get update -qq \
    && apt-get install -y -q --no-install-recommends tree \
                                                     vim \
                                                     emacs-nox \
                                                     nano \
                                                     ncdu \
                                                     graphviz \
                                                     xauth \
                                                     xterm \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


#-----------------------
# Create new user: neuro
#-----------------------
RUN useradd --no-log-init --no-user-group --create-home --shell /bin/bash neuro
USER neuro
ENV PROFILE='/home/neuro/.profile'
RUN echo "alias ls='ls -lha --color=auto' " >> $PROFILE
RUN echo "alias rm='rm -i' " >> $PROFILE
ENV PROFILE='/home/neuro/.profile'


#---------------------------
# Install Miniconda3: 4.6.14
#---------------------------
USER neuro

ENV CONDA_DIR=/opt/conda
ENV PATH=/opt/conda/bin:$PATH
RUN miniconda_installer=/tmp/miniconda.sh \
    && curl -sSL --retry 5 -o $miniconda_installer https://repo.continuum.io/miniconda/Miniconda3-4.6.14-Linux-x86_64.sh \
    && /bin/bash $miniconda_installer -b -p $CONDA_DIR \
    && rm -f $miniconda_installer \
    && conda config --system --set auto_update_conda false \
    && conda config --system --set show_channel_urls true \
    && sync


#----------------------------------------
# Set Directory Structure and Permissions
#----------------------------------------
USER root

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

# Conda root:
RUN chown neuro:users -R /opt/conda


#-----------------------
# Conda Install Packages
#-----------------------
USER neuro

RUN conda config --add channels conda-forge 

RUN conda install -y pytest \
                     traits \
                     pandas \
                     dask \
                     matplotlib \
                     scikit-learn \
                     scikit-image \
                     seaborn \
                     nibabel \
                     scipy \
                     graphviz \
                     python-graphviz \
                     networkx \
                     pydot \
                     h5py \
                     pytables \
                     zarr \
    && sync

RUN conda install -c aramislab pybids
RUN conda install   nipype \
                    nilearn \
                    datalad[full] \
                    nipy \
                    dask \
                    fsleyes \
    && sync
    
RUN conda clean --all


#----------
# Setup FSL
#----------
USER neuro
RUN echo "source /etc/fsl/fsl.sh" >> $PROFILE


#----------------------------------------
# Add ANTS directory to PATH and ANTSPATH
#----------------------------------------
USER neuro

ENV PATH=$PATH:/usr/lib/ants/
ENV ANTSPATH=/usr/lib/ants/
RUN echo "export PATH=$PATH:/usr/lib/ants/" >> $PROFILE
RUN echo "export ANTSPATH=/usr/lib/ants/" >> $PROFILE


#----------
# For Xauth
#----------
USER neuro
RUN touch /home/neuro/.Xauthority


#----------------------------------
# Define ROOT password: FOR TESTING
#----------------------------------
USER root
RUN echo "root:Docker!" | chpasswd


#---------------------
# Login as user: neuro
#---------------------
USER neuro
WORKDIR /home/neuro
