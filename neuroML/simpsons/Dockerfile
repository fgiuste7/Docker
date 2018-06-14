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

USER root
RUN apt-get update -qq && apt-get install -yq --no-install-recommends \
    apt-utils ca-certificates curl locales unzip sudo gnupg dirmngr \
    nano vim \
    libsm6 libxext6 \
    libxrender-dev \
    python-tk \
    && apt-get clean

RUN add-apt-repository -y ppa:webupd8team/sublime-text-3 \
    && sudo apt-get update \
    && sudo apt-get install -yq sublime-text-installer

RUN pip install opencv-python

USER neuro