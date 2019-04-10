# 4/9/2019 (FG)
# fgiuste/neuro:nopswd
#------------------------------------------------
# Inherits: phusion/baseimage:0.10.2            |
# https://github.com/phusion/baseimage-docker   |
# From Ubuntu 16.04.5                           |
#------------------------------------------------
FROM fgiuste/jupyter:nopswd

#---------------------------------------
# Create Default Entrypoint to load FSL:
#---------------------------------------
USER root

RUN echo 'source /etc/fsl/fsl.sh' >> $BASHRC

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
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

#--------------------------
# Conda Install (+nibabel):
#--------------------------
USER root
RUN conda install -y nibabel \
                     graphviz \
                     python-graphviz \
                     networkx \
                     pydot \
    && sync && conda clean -tipsy \
    && sync

RUN bash -c "rm -rf /opt/conda/pkgs/*"

#----------------
# Install nipype:
#----------------
USER root
RUN pip install --no-cache-dir \
                https://github.com/nipy/nipype/tarball/master \
                https://github.com/INCF/pybids/tarball/master \
                nipy \
    && sync

#-----------------------------------------
# Set Directory Structure and Permissions:
#-----------------------------------------
USER root
RUN chmod -R 777 /etc/fsl

#--------------------------------------
# Add ANTS and FSL directories to PATH:
#--------------------------------------
USER mainuser
ENV ANTSPATH=/usr/lib/ants/
ENV PATH=${PATH}:${ANTSPATH}

ENV FSLDIR=/usr/local/fsl
ENV PATH=${FSLDIR}/bin:${PATH}

#---------------------------------------------------
# Login as root: ENTRYPOINT will switch to mainuser:
#---------------------------------------------------
USER root