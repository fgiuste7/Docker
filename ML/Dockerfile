# 4/11/2019 (FG)
# fgiuste/ml:py3
#----------------------------------------------------------
# Inherits: tensorflow/tensorflow:latest-gpu-py3 (4/11/2019)
# https://github.com/jupyter/docker-stacks/blob/master/tensorflow-notebook/Dockerfile
#----------------------------------------------------------
FROM tensorflow/tensorflow:latest-gpu-py3
ENV PROFILE='/home/main/.profile'

#----------------------------------------------
# Create new user: main
#----------------------------------------------
USER root
RUN useradd --no-user-group --create-home --shell /bin/bash main

#---------------------------------------
# Add profile with personal preferences:
#---------------------------------------
USER main
RUN echo "alias ls='ls -lha --color=auto' " >> $PROFILE
RUN echo "alias rm='rm -i' " >> $PROFILE

#----------------------------------------
# Jupyter Notebook Profile setup
# Also sets up server password.
# Change here to create your own password
#----------------------------------------
USER root

RUN mkdir -p /home/main/.jupyter \
    && echo c.NotebookApp.ip = \"0.0.0.0\" > /home/main/.jupyter/jupyter_notebook_config.py

RUN echo "{\"NotebookApp\": \
    { \"password\": \"sha1:317d49d226c9:09f54bfd5868c8897e261a281fa9b7fea8904c5d\" } } \
    " >> /home/main/.jupyter/jupyter_notebook_config.json

#------------------------------
# Define ROOT password: Docker!
#------------------------------
USER root
RUN echo "root:Docker!" | chpasswd

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

RUN add-apt-repository -y ppa:webupd8team/sublime-text-3 \
    && sudo apt-get update -qq \
    && sudo apt-get install -y -q sublime-text-installer

RUN apt-get update -qq \
    && apt-get install -y -q --no-install-recommends vim \
                                                     nano \
                                                     less \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

#----------------------------
# Install niwidgets, nilearn:
#----------------------------
USER root
RUN pip install --no-cache-dir niwidgets nilearn

#----------------------
# Install opencv2-python
#----------------------
USER root
RUN pip install --no-cache-dir opencv2-python

#----------------------------------
# Change Folder Permissions as root
#----------------------------------
USER root

# Change file permissions
RUN chmod -R 777 /home/main && chmod a+s /home/main
RUN mkdir -p /code && chmod -R 777 /code
RUN mkdir -p /data && chmod -R 777 /data
RUN mkdir -p /output && chmod -R 777 /output
RUN mkdir -p /app && chmod -R 777 /app
RUN chmod -R 777 /notebooks

#---------------------
# Login as user: main
#---------------------
USER main
WORKDIR /home/main

# Personal Preference:
ENV ls='ls -lh --color=auto' 

ENTRYPOINT ["jupyter-notebook", "--notebook-dir=/"]


