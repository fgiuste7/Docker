# 12/28/2018 (FG)
# 6/04/2019 (FG)
# Felipe Giuste
# Webix Papaya Viewer Image
# fgiuste/nodejs:webixPapaya

#---------------------
# Ubuntu 18 base image
#---------------------
FROM fgiuste/base:nodejs

#------------
# install git
#------------
USER root
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y git-all

#---------------------------
# Add scripts to final image
#---------------------------
USER root
RUN git clone --quiet https://github.com/dgutman/webixPapaya.git /apps/

#------------------
# Login as mainuser
#------------------
USER mainuser
