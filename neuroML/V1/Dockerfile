# neuroML (FG)
# 
# To Build Docker Image:
# cd ${Dockerfile_Directory}
# docker build --tag ${image_name} .

#----------------------------------------------------------
# Original Dockerfile from: tensorflow/tensorflow:latest-gpu
# https://github.com/jupyter/docker-stacks/blob/master/tensorflow-notebook/Dockerfile
#----------------------------------------------------------
# This version adds:
# Girder, Keras
#----------------------------------------------------------

FROM tensorflow/tensorflow:latest-gpu
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


#-------------------------------
# Jupyter Notebook Profile setup
#-------------------------------
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

#----------------------------------------------
# Define ROOT password: Docker!
#----------------------------------------------
USER root
RUN echo "root:Docker!" | chpasswd

#----------------------------------------------
# Login as user: neuro
#----------------------------------------------
USER neuro
WORKDIR /home/neuro
RUN /home/neuro/.profile

ENTRYPOINT ["jupyter-notebook", "--notebook-dir=/"]


