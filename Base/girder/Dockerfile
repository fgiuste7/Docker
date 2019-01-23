# 1/22/2019 (FG)
# fgiuste/base:girder
# Working? Unkown
#------------------------------------------------
# Inherits: phusion/baseimage:0.10.2            |
# https://github.com/phusion/baseimage-docker   |
# From Ubuntu 16.04.5                           |
#------------------------------------------------
FROM fgiuste/base:nodejs

#------------------------------------
# Install build essentials (gcc etc):
#------------------------------------
USER root
RUN apt-get install -y build-essential && apt-get update

#---------------
# install mongo:
#---------------
USER root
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 9DA31620334BD75D9DCB49F368818C72E52529D4
RUN echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/4.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.0.list \
    && apt-get update
RUN apt-get install -y mongodb-org && apt-get update
# RUN service mongod start

#---------------------
# Install python3-dev:
#---------------------
USER root
RUN apt-get install -y python3-dev && apt-get update

#-------------
# Install pip:
#-------------
USER root
RUN apt-get install -y python3-setuptools && apt-get update
RUN easy_install3 pip

#--------------------
# apt-get autoremove:
#--------------------
USER root
RUN apt-get autoremove

#---------------
# Instal girder:
#---------------
USER root
RUN pip install girder
RUN mkdir /data/db
RUN mongod & \
    girder-install web

#----------------------------------------------
# Change entrypoint to start mongod and girder:
#----------------------------------------------
RUN echo 'mongod & \' >> $USR_ENTRYPOINT \
    && echo 'girder serve' >> $USR_ENTRYPOINT 

ENTRYPOINT ["/sbin/my_init", "--", "/home/startup.sh"]

EXPOSE 8080

#------------
# How to run:
#------------
# within project directory containing index.html
# docker run --rm -v ${PWD}:/app/:rw fgiuste/base:nodejs