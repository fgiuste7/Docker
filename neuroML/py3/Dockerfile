# neuroML (FG)
# 
# To Build Docker Image:
# cd ${Dockerfile_Directory}
# docker build --tag ${image_name} .

#----------------------------------------------------------
# Original Dockerfile from: tensorflow/tensorflow:latest-gpu-py3 (8/15/2018)
# https://github.com/jupyter/docker-stacks/blob/master/tensorflow-notebook/Dockerfile
#----------------------------------------------------------
# This version adds:
# Girder, Keras
#----------------------------------------------------------

FROM tensorflow/tensorflow:latest-gpu-py3
ENV PROFILE='/home/neuro/.profile'

#----------------------------------------------
# Create new user: neuro
#----------------------------------------------
USER root
RUN useradd --no-user-group --create-home --shell /bin/bash neuro

RUN mkdir -p /home/neuro/

USER neuro
RUN echo "alias ls='ls -lha --color=auto' " >> $PROFILE
RUN echo "alias rm='rm -i' " >> $PROFILE

#---------------
# Install Girder
#---------------
USER root
RUN pip install keras girder girder-client


#----------------------------------------
# Jupyter Notebook Profile setup
# Also sets up server password.
# Change here to create your own password
#----------------------------------------
USER root

RUN mkdir -p /home/neuro/.jupyter \
    && echo c.NotebookApp.ip = \"0.0.0.0\" > /home/neuro/.jupyter/jupyter_notebook_config.py

RUN echo "{\"NotebookApp\": \
    { \"password\": \"sha1:317d49d226c9:09f54bfd5868c8897e261a281fa9b7fea8904c5d\" } } \
    " >> /home/neuro/.jupyter/jupyter_notebook_config.json


#----------------------------------------------
# Change Folder Permissions as root
#----------------------------------------------
USER root

# Change file permissions
RUN chmod -R 777 /home/neuro
RUN chmod -R 777 /notebooks
RUN mkdir /data && chmod -R 777 /data
RUN mkdir /output && chmod -R 777 /output

#------------------------------
# Define ROOT password: Docker!
#------------------------------
USER root
RUN echo "root:Docker!" | chpasswd


#---------------------
# install: 
# basic bash utilities
# screen
#---------------------
USER root
RUN apt-get update -qq && apt-get install -yq --no-install-recommends \
    apt-utils ca-certificates curl locales unzip sudo gnupg dirmngr \
    libsm6 libxext6 \
    libxrender-dev \
    screen \
    && apt-get clean


#-------------
# Text Editors
#-------------
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
# opencv-python
# python-tk
#--------------
RUN pip install opencv-python
RUN apt-get update -qq && apt-get install -yq --no-install-recommends python-tk


#----------------------------------
# Change Folder Permissions as root
#----------------------------------
USER root

# Change file permissions
RUN chmod -R 777 /home/neuro
RUN mkdir -p /code && chmod -R 777 /code
RUN mkdir -p /data && chmod -R 777 /data
RUN mkdir -p /output && chmod -R 777 /output
RUN mkdir -p /app && chmod -R 777 /app
RUN chmod -R 777 /home && chmod a+s /home

#---------------------
# Install nvidia-ml-py
#---------------------
USER root

RUN pip install --no-cache-dir nvidia-ml-py

#---------------------
# Login as user: neuro
#---------------------
USER neuro
WORKDIR /home/neuro

ENV ls='ls -lh --color=auto'

ENTRYPOINT ["jupyter-notebook", "--notebook-dir=/"]


