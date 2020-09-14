# Created: 04/11/2019 (FG)
# Updated: 07/24/2020 (FG)
# fgiuste/ml:latest
#----------------------------------------------------------
# Inherits: tensorflow/tensorflow:version-gpu-py3 
# https://github.com/jupyter/docker-stacks/blob/master/tensorflow-notebook/Dockerfile
#----------------------------------------------------------
FROM tensorflow/tensorflow:2.2.0rc2-gpu-py3
ENV PROFILE='/home/mainuser/.profile'

#-----------------------------
# Non-interactive Frontend 
# Prevents installation stalls
#-----------------------------
ENV DEBIAN_FRONTEND=noninteractive 

#--------------------------
# Create new user: mainuser
#--------------------------
USER root
RUN useradd --no-user-group --create-home --shell /bin/bash mainuser

#---------------------------------------
# Add profile with personal preferences:
#---------------------------------------
USER mainuser
RUN echo "alias ls='ls -lha --color=auto' " >> $PROFILE
RUN echo "alias rm='rm -i' " >> $PROFILE

#------------------------
# Jupyter Notebook Setup:
#------------------------
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
# vim, nano, less, graphviz
#----------------------
USER root
RUN apt-get update -qq \
    && apt-get install -y -q --no-install-recommends vim \
                                                     nano \
                                                     less \
						     graphviz \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

#----------------------
# Install 
# scipy
# scikit-learn
# scikit-image
# imageio
# graphviz
# pydot
# tqdm
#----------------------
#USER root
RUN pip install scipy==1.4.1
RUN pip install scikit-learn==0.23.1
RUN pip install scikit-image==0.17.2
RUN pip install imageio==2.9.0
RUN pip install graphviz==0.14.1
RUN pip install pydot==1.4.1
RUN pip install tqdm==4.48.0
RUN pip install joblib==0.16.0

#-----------------
# Install seaborn:
#-----------------
USER root
RUN pip install --no-cache-dir seaborn==0.10.1

#-----------------------------
# Install pandoc and TeX Live:
# To convert: ipynb -> pdf
#-----------------------------
USER root
RUN apt-get update -qq && apt-get install -yq pandoc texlive-xetex \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

#---------------------------
# Change Folder Permissions:
#---------------------------
USER root

# Change file permissions
RUN chmod -R 777 /home/mainuser && chmod a+s /home/mainuser
RUN mkdir -p /code && chmod -R 777 /code
RUN mkdir -p /data && chmod -R 777 /data
RUN mkdir -p /output && chmod -R 777 /output
RUN mkdir -p /apps && chmod -R 777 /apps
RUN mkdir -p /notebooks && chmod -R 777 /notebooks

#-------------------------
# Login as user: mainuser:
#-------------------------
USER mainuser
WORKDIR /home/mainuser

CMD ["jupyter-notebook", "--notebook-dir=/"]


