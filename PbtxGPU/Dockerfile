# pbtxgpu (FG): requires nvidia-docker for GPU
# 
# To Build Docker Image:
# cd ${Dockerfile_Directory}
# docker build --tag ${image_name} .

#----------------------------------------------------------
# Original Dockerfile from: nvidia/cuda:9.1-runtime-ubuntu16.04
# https://hub.docker.com/r/nvidia/cuda/tags/
#----------------------------------------------------------

FROM nvidia/cuda:9.1-runtime-ubuntu16.04


#-----------------------------------------------------------------
# Install common dependencies and create default entrypoint:
# From Neurodocker: https://hub.docker.com/r/kaczmarj/neurodocker/
#-----------------------------------------------------------------
RUN apt-get update -qq && apt-get install -yq --no-install-recommends \
      apt-utils ca-certificates curl locales unzip sudo gnupg dirmngr python-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && chmod 777 /opt && chmod a+s /opt


RUN apt-get update -qq && apt-get install -yq --no-install-recommends build-essential python-pip
RUN pip install --upgrade pip # 10.1.0
RUN pip install --upgrade setuptools

#----------------------------------------------
# Create new user: neuro
#----------------------------------------------
USER root

ENV PROFILE='/home/neuro/.profile'
RUN useradd --no-user-group --create-home --shell /bin/bash neuro

RUN mkdir -p /home/neuro/ && chmod -R 777 /home && chmod a+s /home

USER neuro
RUN echo "alias ls='ls -lha --color=auto' " >> $PROFILE
RUN echo "alias rm='rm -i' " >> $PROFILE


#---------------
# Jupyter Install
#---------------
USER root
RUN pip install --no-cache-dir jupyter

#---------------
# Jupyter Setup
#---------------
USER root

# BASH: Allows Jupyter to run:
RUN mkdir -p /home/neuro/.jupyter \
    && echo c.NotebookApp.ip = \"0.0.0.0\" > /home/neuro/.jupyter/jupyter_notebook_config.py

# BASH: Set notebook password:
RUN echo "{\"NotebookApp\": \
    { \"password\": \"sha1:317d49d226c9:09f54bfd5868c8897e261a281fa9b7fea8904c5d\" } } \
    " >> /home/neuro/.jupyter/jupyter_notebook_config.json


#----------------------------------------------
# Change Folder Permissions as root
#----------------------------------------------
USER root

# Change file permissions
RUN chmod -R 777 /home/neuro
RUN mkdir /code && chmod -R 777 /code
RUN mkdir /data && chmod -R 777 /data
RUN mkdir /output && chmod -R 777 /output
RUN mkdir /app && chmod -R 777 /app

#----------------------------------------------
# Define ROOT password: Docker!
#----------------------------------------------
USER root
RUN echo "root:Docker!" | chpasswd


#---------------
# install screen
#---------------
USER root

RUN apt-get update -qq \
    && apt-get install -y -q --no-install-recommends screen \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


#----------------------------------------------------------
# NeuroDebian Keys
# http://neuro.debian.net/install_pkg.html?p=ants
# Neurodebian:
# https://github.com/neurodebian/dockerfiles/blob/88af27888a5aee76924c3b6840fc47f9cd8f63cb/dockerfiles/xenial-non-free/Dockerfile
#----------------------------------------------------------
# RUN wget -O- http://neuro.debian.net/lists/xenial.us-tn.full | sudo tee /etc/apt/sources.list.d/neurodebian.sources.list
# RUN apt-key adv --recv-keys --keyserver hkp://pool.sks-keyservers.net:80 0xA5D32F012649A5A9
# https://bugs.debian.org/830696 (apt uses gpgv by default in newer releases, rather than gpg)

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


#----------------------------------------------------------
# NeuroDebian Packages: FSL, FSL Atlasas, Text Editors
#----------------------------------------------------------
USER root

RUN apt-get update -qq \
    && apt-get install -y -q --no-install-recommends fsl \
                                                     fsl-atlases \
                                                     tree \
                                                     vim \
                                                     nano \
                                                     less \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


#---------------
# Install Nipype
#---------------
USER root

RUN pip install --no-cache-dir https://github.com/nipy/nipype/tarball/master \
                               https://github.com/INCF/pybids/tarball/master \
                               nilearn \
                               nipy && sync


#----------------------------------------------
# Login as user: neuro
#----------------------------------------------
USER neuro
WORKDIR /home/neuro
RUN /home/neuro/.profile

ENTRYPOINT ["bash"]


