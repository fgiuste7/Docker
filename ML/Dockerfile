# 4/11/2019 (FG)
# fgiuste/ml:py3
#----------------------------------------------------------
# Inherits: tensorflow/tensorflow:latest-gpu-py3 (4/11/2019)
# https://github.com/jupyter/docker-stacks/blob/master/tensorflow-notebook/Dockerfile
#----------------------------------------------------------
FROM tensorflow/tensorflow:latest-gpu-py3
ENV PROFILE='/home/mainuser/.profile'

#----------------------------------------------
# Create new user: mainuser
#----------------------------------------------
USER root
RUN useradd --no-user-group --create-home --shell /bin/bash mainuser

#---------------------------------------
# Add profile with personal preferences:
#---------------------------------------
USER mainuser
RUN echo "alias ls='ls -lha --color=auto' " >> $PROFILE
RUN echo "alias rm='rm -i' " >> $PROFILE

#----------------------------------------
# Jupyter Notebook Profile setup
# Also sets up server password.
# Change here to create your own password
#----------------------------------------
USER root

RUN mkdir -p /home/mainuser/.jupyter \
    && echo 'c.NotebookApp.ip = "0.0.0.0"' > /home/mainuser/.jupyter/jupyter_notebook_config.py

#--------------------
# Install ipywidgets:
#--------------------
USER root
RUN pip install ipywidgets


#---------------------
# Install: 
# basic bash utilities
# screen
#---------------------
USER root
RUN apt-get update -qq && apt-get install -yq --no-install-recommends \
    apt-utils ca-certificates curl locales unzip sudo gnupg dirmngr \
    libsm6 libxext6 \
    libxrender-dev \
    tree \
    screen \
    && apt-get clean

#----------------------
# Install Text Editors:
# vim, nano, less
#----------------------
USER root
RUN apt-get update -qq \
    && apt-get install -y -q --no-install-recommends vim \
                                                     nano \
                                                     less \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

#----------------------
# Install scipy:
# Version: 1.2.1
# Install scikit-learn:
# Version: 0.20.3
#----------------------
#USER root
#RUN pip install scipy==1.2.1
#RUN pip install scikit-learn==0.20.3

#-----------------------
# Install opencv-python:
# Version: 4.1.0.25
#-----------------------
USER root
RUN pip install --no-cache-dir opencv-python==4.1.0.25

#----------------
# Install dask:
# Version: 0.12.0
#----------------
USER root
RUN pip install --no-cache-dir "dask[complete]"==1.1.5

#---------------
# Install zarr:
# Version: 2.3.1
#---------------
USER root
RUN pip install --no-cache-dir zarr==2.3.1

#-----------------------------------
# Change Folder Permissions as root:
#-----------------------------------
USER root

# Change file permissions
RUN chmod -R 777 /home/mainuser && chmod a+s /home/mainuser
RUN mkdir -p /code && chmod -R 777 /code
RUN mkdir -p /data && chmod -R 777 /data
RUN mkdir -p /output && chmod -R 777 /output
RUN mkdir -p /apps && chmod -R 777 /apps
RUN chmod -R 777 /notebooks

#------------------------------
# Define ROOT password: Docker!
#------------------------------
USER root
RUN echo "root:Docker!" | chpasswd

#---------------------
# Login as user: mainuser:
#---------------------
USER mainuser
WORKDIR /home/mainuser

CMD ["jupyter-notebook", "--notebook-dir=/"]


