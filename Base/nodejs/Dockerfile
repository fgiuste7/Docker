# 12/26/2018 (FG)
# fgiuste/base:nodejs
#------------------------------------------------
# Inherits: phusion/baseimage:0.10.2            |
# https://github.com/phusion/baseimage-docker   |
# From Ubuntu 16.04.5                           |
#------------------------------------------------
FROM fgiuste/base:base

#---------------------------------------------------
# Instal node.js through nvm (node version manager):
#---------------------------------------------------
USER root
RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash

#---------------------------------------
# install nvm (node.js version manager):
#---------------------------------------
USER root
RUN nvm install stable

#-------------------------
# install npm and node.js:
#-------------------------
USER root
RUN wget -qO- https://deb.nodesource.com/setup_8.x | sudo -E bash -
RUN apt-get install nodejs

#------------------------
# install webix with npm:
#------------------------
USER root
RUN npm install --save webix

#-------------------------
# install jquery with npm:
#-------------------------
USER root
RUN npm install --save jquery

#-------------------------------------
# initialize repo (within repository):
#-------------------------------------
USER root
RUN npm init

#------------------------------------
# Run app (within githib repository):
#------------------------------------
USER root
RUN http-server -a localhost -p 8888 -c-1

#---------------------------------------------------
# Login as root: ENTRYPOINT will switch to mainuser:
#---------------------------------------------------
USER root