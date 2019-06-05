# 12/26/2018 (FG)
# 6/04/2019 (FG)
# Felipe Giuste
# Node.js Image
# fgiuste/base:nodejs

#---------------------
# Ubuntu 18 base image
#---------------------
FROM fgiuste/base:base

#-------------------------------------
# Instal nvm (node.js version manager)
#-------------------------------------
USER mainuser
RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash

#------------------------------------------
# install node.js:
# This loads nvm then loads bash_completion
#------------------------------------------
USER mainuser
ENV NVM_DIR="$USR_HOME/.nvm"
RUN [ -s "${NVM_DIR}/nvm.sh" ] && \. "${NVM_DIR}/nvm.sh" \
    && [ -s "${NVM_DIR}/bash_completion" ] && \. "${NVM_DIR}/bash_completion" \
    && nvm install stable

#------------------------
# install npm and node.js
#------------------------
USER root
RUN wget -qO- https://deb.nodesource.com/setup_8.x | sudo -E bash - \
    && apt-get install -y nodejs

#--------------------
# install http-server
#--------------------
RUN npm install http-server -g

#---------------------------------
# Install dependencies and Run app
#---------------------------------
USER mainuser
WORKDIR /apps
RUN echo "#!/bin/bash"  > "$USR_HOME/run_app.sh"
RUN echo "npm install /apps/." >> "$USR_HOME/run_app.sh"
RUN echo "http-server -p 8888 -c-1 /apps" >> "$USR_HOME/run_app.sh"

CMD $USR_HOME/run_app.sh

#----------------
# app permissions
#----------------
USER root
RUN chmod 757 $USR_HOME/run_app.sh

#------------------
# Login as mainuser
#------------------
USER mainuser

#-----------
# How to run
#-----------
# within project directory containing index.html
# docker run --rm -p 8123:8888 -v ${PWD}:/app/:rw fgiuste/base:nodejs
