# neuro (FG): V3
# 
# To Build Docker Image:
# cd ${Dockerfile_Directory}
# docker build --tag ${image_name} .

#----------------------------------------------------------
# Original Neuro Dockerfiles from: Neurodocker
# https://github.com/kaczmarj/neurodocker
#----------------------------------------------------------
FROM fgiuste/neuro:V2

#---------------
# install screen
#---------------
USER root

RUN apt-get update -qq \
    && apt-get install -y -q --no-install-recommends screen \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

#---------------
# Install Girder
#---------------
USER root
RUN pip install keras girder girder-client

#--------------------------------------
# make bash the default shell for neuro
#--------------------------------------
USER root
RUN chsh -s /bin/bash neuro

USER neuro


