# 1/29/2020
# Felipe Giuste
# Matlab Runtime Image
# fgiuste/matlab:latest
# Based on: 
# 	fgiuste/base and
# 	https://github.com/flywheel-apps/matlab-mcr/blob/master/2018b/Dockerfile

#------------------------------------------------
# Description:
# Matlab Runtime image on Ubuntu 18
# Creates user: mainuser
# Creates Directories for organized mounting
# ENTRYPOINT ["/home/startup.sh"]
# CMD ["/bin/bash"]
#------------------------------------------------

FROM ubuntu:18.04

#------------
# Basic setup
#------------
USER root
ENV LANG="en_US.UTF-8" \
    LC_ALL="C.UTF-8"


#-----------------------------
# Non-interactive Frontend 
# Prevents installation stalls
#-----------------------------
ENV DEBIAN_FRONTEND=noninteractive 


#--------------------------------------------
# Install common dependencies (+screen +tree)
#--------------------------------------------
RUN apt-get update -qq && apt-get install -yq --no-install-recommends \
    apt-utils \
    ca-certificates \
    curl \
    locales \
    unzip \
    sudo \
    gnupg \
    dirmngr \
    screen \
    tree \
    bzip2 \
    unzip \
    wget \
    xauth \
    xterm \
    xorg \
    && apt-get update -qq \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && localedef --force --inputfile=en_US --charmap=UTF-8 C.UTF-8 


#----------------------------------------
# Install Text Editors (+vim +nano +less)
#----------------------------------------
USER root

RUN apt-get update -qq \
    && apt-get install -y -q --no-install-recommends \
    nano \
    less \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


#--------------------------
# Create new user: mainuser
#--------------------------
USER root
ENV USR_HOME="/home/mainuser"
RUN useradd --no-user-group --create-home --shell /bin/bash mainuser


#--------------------------
# Create Default Entrypoint
#--------------------------
USER root
ENV ENTRYPOINT="/home/startup.sh"

RUN echo '#!/bin/bash' > $ENTRYPOINT \
    && echo 'set +x' >> $ENTRYPOINT \
    && echo 'exec "$@"' >> $ENTRYPOINT

ENTRYPOINT ["/home/startup.sh"]
CMD ["/bin/bash"]


#----------------------------------------
# Set Directory Structure and Permissions
#----------------------------------------
USER root
RUN chmod -R 777 /home
RUN mkdir /data && chmod -R 777 /data
RUN mkdir /output && chmod -R 777 /output
RUN mkdir -p /apps && chmod -R 777 /apps
RUN mkdir -p /mcr-install && chmod -R 777 /mcr-install
RUN mkdir -p /opt/mcr && chmod -R 777 /opt/mcr

RUN mkdir -p /code/scripts \
    && mkdir -p /code/notebooks \
    && chmod -R 777 /code


#----------------------------------
# Define ROOT password: FOR TESTING
#----------------------------------
#USER root
#RUN echo "root:Docker!" | chpasswd


#----------------------------------
# Download Matlab Runtime
#----------------------------------
USER mainuser
WORKDIR /mcr-install
RUN wget -q https://ssd.mathworks.com/supportfiles/downloads/R2019b/Release/3/deployment_files/installer/complete/glnxa64/MATLAB_Runtime_R2019b_Update_3_glnxa64.zip \
	&& unzip -q MATLAB_Runtime_R2019b_Update_3_glnxa64.zip \
	&& ./install -destinationFolder /opt/mcr -agreeToLicense yes -mode silent \
	&& cd /home/mainuser
ENV LD_LIBRARY_PATH /opt/mcr/v97/runtime/glnxa64:/opt/mcr/v97/bin/glnxa64:/opt/mcr/v97/sys/os/glnxa64:/opt/mcr/v97/extern/bin/glnxa64


#-------------------------------
# Delete Matlab Runtime Download
#-------------------------------
USER root
RUN rm -r /mcr-install


#------------------
# Login as mainuser
#------------------
USER mainuser
WORKDIR /code