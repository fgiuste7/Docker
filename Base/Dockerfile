# 12/26/2018 (FG)
# fgiuste/base:base
#------------------------------------------------
# Inherits: phusion/baseimage:0.10.2            |
# https://github.com/phusion/baseimage-docker   |
# From Ubuntu 16.04.5                           |
#------------------------------------------------
FROM phusion/baseimage:0.10.2

#---------------------------------------------
# Install common dependencies (+screen +tree):
#---------------------------------------------
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

#-----------------------------------------
# Install Text Editors (+vim +nano +less):
#-----------------------------------------
USER root

RUN apt-get update -qq \
    && apt-get install -y -q --no-install-recommends vim \
                                                     nano \
                                                     less \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

#---------------------------
# Create new user: mainuser:
#---------------------------
USER root
ENV BASHRC="/home/mainuser/.bash_aliases"
ENV USR_HOME="/home/mainuser"
RUN useradd --no-user-group --create-home --shell /bin/bash mainuser

user mainuser
WORKDIR /home/mainuser
RUN echo "alias ls='ls -lh --color=auto'" >> $BASHRC

#---------------------------
# Create Default Entrypoint:
#---------------------------
USER root
ENV USR_ENTRYPOINT="/home/startup.sh"

RUN echo '#!/usr/bin/env bash' >> $USR_ENTRYPOINT \
&& echo 'set +x' >> $USR_ENTRYPOINT \
&& echo 'if [ -z "$*" ]; then /usr/bin/env bash; else $*; fi' >> $USR_ENTRYPOINT

ENTRYPOINT ["/sbin/my_init", "--", "setuser", "mainuser", "/home/startup.sh"]

#-----------------------------------------
# Set Directory Structure and Permissions:
#-----------------------------------------
USER root
RUN chmod -R 777 /home
RUN mkdir /data && chmod -R 777 /data
RUN mkdir /output && chmod -R 777 /output
RUN chmod 777 /home/startup.sh

RUN mkdir -p /code/scripts \
    && mkdir -p /code/notebooks \
    && chmod -R 777 /code

RUN mkdir -p /apps && chmod -R 777 /apps

#-----------------------------------
# Define ROOT password: FOR TESTING:
#-----------------------------------
USER root
RUN echo "root:Docker!" | chpasswd

#---------------------------------------------------
# Login as root: ENTRYPOINT will switch to mainuser:
#---------------------------------------------------
USER root