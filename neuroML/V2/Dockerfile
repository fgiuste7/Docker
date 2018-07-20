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
# install: 
# basic bash utilities
# screen
#---------------
USER root
RUN apt-get update -qq && apt-get install -yq --no-install-recommends \
    apt-utils ca-certificates curl locales unzip sudo gnupg dirmngr \
    libsm6 libxext6 \
    libxrender-dev \
    screen \
    && apt-get clean


#--------------
# Text Editors
#--------------
USER root

RUN apt-get update -qq \
    && apt-get install -y -q --no-install-recommends tree \
                                                     vim \
                                                     nano \
                                                     less \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN add-apt-repository -y ppa:webupd8team/sublime-text-3 \
    && sudo apt-get update -qq \
    && sudo apt-get install -y -q sublime-text-installer


#---------------
# install girder
#---------------
USER root

RUN pip install --no-cache-dir girder girder-client


#--------------------------
# install pymongo and pycap
#--------------------------
USER root

RUN pip install --no-cache-dir pymongo pycap


#------------------
# Install niwidgets
#------------------
USER root
RUN pip install --no-cache-dir niwidgets nilearn


#--------------
# For Simpsons:
# opencv-python
# python-tk
#--------------
RUN pip install opencv-python
RUN apt-get update -qq && apt-get install -yq --no-install-recommends python-tk


#----------------------------------------------
# Change Folder Permissions as root
#----------------------------------------------
USER root

# Change file permissions
RUN chmod -R 777 /home/neuro
RUN mkdir -p /code && chmod -R 777 /code
RUN mkdir -p /data && chmod -R 777 /data
RUN mkdir -p /output && chmod -R 777 /output
RUN mkdir -p /app && chmod -R 777 /app
RUN chmod -R 777 /home && chmod a+s /home


#----------------------
# Log in as neuro
# Entrypoint is Jupyter
#----------------------
USER neuro

