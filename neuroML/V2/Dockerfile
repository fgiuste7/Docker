# neuroML (FG): Simpsons version
# 
# To Build Docker Image:
# cd ${Dockerfile_Directory}
# docker build --tag ${image_name} .

#----------------------------------------------------------
# Original Dockerfile from: tensorflow/tensorflow:latest-gpu
# https://github.com/jupyter/docker-stacks/blob/master/tensorflow-notebook/Dockerfile
#----------------------------------------------------------

FROM fgiuste/neuroml:V1

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

USER neuro

