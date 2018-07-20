# neuroML (FG): Simpsons version
# 
# To Build Docker Image:
# cd ${Dockerfile_Directory}
# docker build --tag ${image_name} .

#----------------------------------------------------------
# Original Dockerfile from: tensorflow/tensorflow:latest-gpu
# https://github.com/jupyter/docker-stacks/blob/master/tensorflow-notebook/Dockerfile
#----------------------------------------------------------

FROM fgiuste/neuroml:V2

#-------------
# Install nvidia-ml-py
#-------------
USER root

RUN pip install --no-cache-dir nvidia-ml-py

#----------------------
# Log in as neuro
# Entrypoint is Jupyter
#----------------------
USER neuro