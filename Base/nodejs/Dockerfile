# 12/26/2018 (FG)
# fgiuste/base:nodejs
#------------------------------------------------
# Inherits: phusion/baseimage:0.10.2            |
# https://github.com/phusion/baseimage-docker   |
# From Ubuntu 16.04.5                           |
#------------------------------------------------
FROM fgiuste/base:base

#--------------------------------------
# Instal nvm (node.js version manager):
#--------------------------------------
USER mainuser
RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash

#-------------------------------------------
# install node.js:
# This loads nvm then loads bash_completion:
#-------------------------------------------
USER mainuser
ENV NVM_DIR="$USR_HOME/.nvm"
RUN [ -s "${NVM_DIR}/nvm.sh" ] && \. "${NVM_DIR}/nvm.sh" \
    && [ -s "${NVM_DIR}/bash_completion" ] && \. "${NVM_DIR}/bash_completion" \
    && nvm install stable

#-------------------------
# install npm and node.js:
#-------------------------
USER root
RUN wget -qO- https://deb.nodesource.com/setup_8.x | sudo -E bash - \
    && apt-get install -y nodejs

#---------------------
# install http-server:
#---------------------
RUN npm install http-server -g

#-----------------------------------
# Install dependencies and Run app :
#-----------------------------------
USER mainuser
WORKDIR /app
RUN echo "#!/bin/bash"  > "$USR_HOME/run_app.sh"
RUN echo "npm install /app/." >> "$USR_HOME/run_app.sh"
RUN echo "http-server -p 8888 -c-1 /app" >> "$USR_HOME/run_app.sh"

CMD $USR_HOME/run_app.sh

#---------------------------------------------------
# Login as root: ENTRYPOINT will switch to mainuser:
#---------------------------------------------------
USER root
RUN chmod 757 $USR_HOME/run_app.sh