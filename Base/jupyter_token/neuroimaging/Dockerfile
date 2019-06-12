# Created: 4/9/2019 (FG)
# Updated: 6/12/2019 (FG)
# fgiuste/base:jupyter
#--------------
# OS: Ubuntu 18
#--------------
FROM fgiuste/base:jupyter_token


#--------------
# Misc Packages
#--------------
USER root

RUN apt-get update -qq \
    && apt-get install -y -q --no-install-recommends ncdu \
                                                     graphviz \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


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
    echo 'deb http://neuro.debian.net/debian bionic main'; \
    echo 'deb http://neuro.debian.net/debian data main'; \
    echo '#deb-src http://neuro.debian.net/debian-devel bionic main'; \
} > /etc/apt/sources.list.d/neurodebian.sources.list

RUN sed -i -e 's,main *$,main contrib non-free,g' /etc/apt/sources.list.d/neurodebian.sources.list; grep -q 'deb .* multiverse$' /etc/apt/sources.list || sed -i -e 's,universe *$,universe multiverse,g' /etc/apt/sources.list


#---------------------
# NeuroDebian Packages
#---------------------
USER root

RUN DEBIAN_FRONTEND=noninteractive apt-get update -qq \
    && apt-get install -y -q --no-install-recommends convert3d \
                                                     ants \
                                                     fsl-complete \
                                                     fsl-atlases \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


#----------------------------------------
# Set Directory Structure and Permissions
#----------------------------------------
USER root

RUN chmod -R 777 /etc/fsl
RUN chmod -R 777 /home/mainuser
RUN chmod 777 /home/startup.sh

# Conda root:
RUN chown mainuser:users -R /opt/conda


#-----------------------
# Conda Install Packages
#-----------------------
USER mainuser

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


#----------------------------------------
# Add ANTS directory to PATH and ANTSPATH
#----------------------------------------
USER mainuser
ENV PATH=$PATH:/usr/lib/ants/
ENV ANTSPATH=/usr/lib/ants/


#----------
# For Xauth
#----------
USER mainuser
RUN touch /home/mainuser/.Xauthority


#---------------------
# Setup FSL ENTRYPOINT
#---------------------
USER root

RUN echo '#!/usr/bin/env bash' > $ENTRYPOINT \
    && echo 'set +x' >> $ENTRYPOINT \
    && echo 'source /etc/fsl/fsl.sh' >> $ENTRYPOINT \
    && echo 'source "$@"' >> $ENTRYPOINT


#------------------------
# Login as user: mainuser
#------------------------
USER mainuser
WORKDIR /home/mainuser