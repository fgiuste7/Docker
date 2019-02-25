# 12/28/2018 (FG)
# fgiuste/nodejs:webixPapaya
#------------------------------------------------
# Inherits: phusion/baseimage:0.10.2            |
# https://github.com/phusion/baseimage-docker   |
# From Ubuntu 16.04.5                           |
#------------------------------------------------
FROM fgiuste/base:nodejs

#-------------
# install git:
#-------------
USER root
RUN apt install -y git-all

#----------------------------
# Add scripts to final image:
#----------------------------
USER root
RUN git clone --quiet https://github.com/dgutman/webixPapaya.git /apps/

#---------------------------------------------------
# Login as root: ENTRYPOINT will switch to mainuser:
#---------------------------------------------------
USER root