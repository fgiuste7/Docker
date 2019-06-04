# 6/04/2019 (FG)
# Felipe Giuste
# Base Image
# fgiuste/base:base

FROM ubuntu:18.04

#--------------------------------------------
# Install common dependencies (+screen +tree)
#--------------------------------------------
USER root
ENV LANG="en_US.UTF-8" \
    LC_ALL="C.UTF-8"

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
    wget \
    && apt-get update -qq \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && localedef --force --inputfile=en_US --charmap=UTF-8 C.UTF-8 

#----------------------------------------
# Install Text Editors (+vim +nano +less)
#----------------------------------------
USER root

RUN apt-get update -qq \
    && apt-get install -y -q --no-install-recommends vim \
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

#------------------------------
# Create mainuser .bash_aliases
#------------------------------
USER mainuser
ENV BASHRC="/home/mainuser/.bash_aliases"
WORKDIR /home/mainuser
RUN echo '#!/usr/bin/env bash' >> $BASHRC \
    echo "alias ls='ls -lh --color=auto'" >> $BASHRC

#--------------------------
# Create Default Entrypoint
#--------------------------
USER root
ENV ENTRYPOINT="/home/startup.sh"

RUN echo '#!/usr/bin/env bash' >> $ENTRYPOINT \
    && echo 'set +x' >> $ENTRYPOINT \
    && echo 'if [ -f "/home/mainuser/.bash_aliases" ]; then source /home/mainuser/.bash_aliases; fi' >> $ENTRYPOINT \
    && echo 'if [ -z "$*" ]; then /usr/bin/env bash; else $*; fi' >> $ENTRYPOINT

ENTRYPOINT ["/home/startup.sh"]

#----------------------------------------
# Set Directory Structure and Permissions
#----------------------------------------
USER root
RUN chmod -R 777 /home
RUN mkdir /data && chmod -R 777 /data
RUN mkdir /output && chmod -R 777 /output
RUN mkdir -p /apps && chmod -R 777 /apps

RUN mkdir -p /code/scripts \
    && mkdir -p /code/notebooks \
    && chmod -R 777 /code


#----------------------------------
# Define ROOT password: FOR TESTING
#----------------------------------
USER root
RUN echo "root:Docker!" | chpasswd

#------------------
# Login as mainuser
#------------------
USER mainuser