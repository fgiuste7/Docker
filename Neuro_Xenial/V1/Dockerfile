# 6/1/2018 (FG)
# 
# To Build Docker Image:
# cd ${Dockerfile_Directory}
# docker build --tag ${image_name} .

#----------------------------------------------------------
# Install Xenial with additional libraries
#----------------------------------------------------------
# https://github.com/docker-library/buildpack-deps/blob/d7da72aaf3bb93fecf5fcb7c6ff154cb0c55d1d1/xenial/Dockerfile
FROM buildpack-deps:xenial

#----------------------------------------------------------
# Install common dependencies and create default entrypoint
#----------------------------------------------------------
ENV LANG="en_US.UTF-8" \
LC_ALL="C.UTF-8" \
ND_ENTRYPOINT="/home/startup.sh"

RUN apt-get update -qq && apt-get install -yq --no-install-recommends \
      apt-utils ca-certificates curl locales unzip sudo gnupg dirmngr \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && localedef --force --inputfile=en_US --charmap=UTF-8 C.UTF-8 \
    && chmod 777 /opt && chmod a+s /opt \
    && if [ ! -f "$ND_ENTRYPOINT" ]; then \
         echo '#!/usr/bin/env bash' >> $ND_ENTRYPOINT \
         && echo 'set +x' >> $ND_ENTRYPOINT \
         && echo 'if [ -z "$*" ]; then /usr/bin/env bash; else $*; fi' >> $ND_ENTRYPOINT; \
       fi \
    && chmod -R 777 /home && chmod a+s /home

ENTRYPOINT ["/home/startup.sh"]
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

#----------------------------------------------------------
# NeuroDebian Packages
#----------------------------------------------------------
RUN apt-get update -qq \
    && apt-get install -y -q --no-install-recommends convert3d \
                                                     ants \
                                                     fsl \
                                                     fsl-atlases \
                                                     graphviz \
                                                     tree \
                                                     git-annex-standalone \
                                                     vim \
                                                     emacs-nox \
                                                     nano \
                                                     less \
                                                     ncdu \
                                                     tig \
                                                     git-annex-remote-rclone \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


#----------------------------------------------
# Create new user: neuro
#----------------------------------------------
RUN useradd --no-user-group --create-home --shell /bin/bash neuro
USER neuro

ENV PROFILE='/home/neuro/.profile'
RUN echo "$isource /etc/fsl/fsl.sh" >> $PROFILE
RUN echo "alias ls='ls -lha --color=auto' " >> $PROFILE
RUN echo "alias rm='rm -i' " >> $PROFILE

#------------------
# Install Miniconda
#------------------
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
                     nibabel \
                     scipy \
                     graphviz \
                     networkx \
                     dask \
                     h5py \
                     pytables \
    && sync && conda clean -tipsy && sync \
    && pip install --no-cache-dir https://github.com/nipy/nipype/tarball/master \
                                  https://github.com/INCF/pybids/tarball/master \
                                  nilearn \
                                  datalad[full] \
                                  nipy \
                                  duecredit \
    && sync


#----------------------------------------------
# Change Folder Permissions as root
#----------------------------------------------
USER root

# BASH: Allows Jupyter to run
RUN mkdir -p /home/neuro/.jupyter \
    && echo c.NotebookApp.ip = \"0.0.0.0\" > /home/neuro/.jupyter/jupyter_notebook_config.py

RUN echo "{\"NotebookApp\": \
    { \"password\": \"sha1:317d49d226c9:09f54bfd5868c8897e261a281fa9b7fea8904c5d\" } } \
    " >> /home/neuro/.jupyter/jupyter_notebook_config.json

# Change file permissions
RUN chmod -R 777 /etc/fsl
RUN chmod -R 777 /home/neuro
RUN mkdir /data && chmod -R 777 /data
RUN mkdir /output && chmod -R 777 /output
RUN chmod 777 /home/startup.sh


#----------------------------------------------
# Define ROOT password: Docker!
#----------------------------------------------
RUN echo "root:Docker!" | chpasswd

# BASH
RUN bash -c "rm -rf /opt/conda/pkgs/*"


#----------------------------------------------
# Login as user: neuro
#----------------------------------------------
USER neuro
WORKDIR /home/neuro
RUN /home/neuro/.profile

# CMD ["/home/neuro/.profile &"]
