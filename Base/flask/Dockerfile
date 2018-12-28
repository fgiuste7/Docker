# 12/27/2018 (FG)
# fgiuste/base:flask
#------------------------------------------------
# Inherits: phusion/baseimage:0.10.2            |
# https://github.com/phusion/baseimage-docker   |
# From Ubuntu 16.04.5                           |
#------------------------------------------------
FROM fgiuste/base:base

#-------------
# install pip:
#-------------
USER root
RUN apt-get update && apt-get install -y python-pip

#---------------
# install flask:
#---------------
USER mainuser
RUN pip install flask

#---------------
# run flask app:
# host='0.0.0.0'
#---------------
USER mainuser
CMD ["python", "/apps/run.py"]

#---------------------------------------------------
# Login as root: ENTRYPOINT will switch to mainuser:
#---------------------------------------------------
USER root

#------------
# How to run:
#------------
# within directory containing run.py and app class (app folder with __init__.py)
# docker run --rm -p8081:8888 -v ${PWD}:/apps/:rw fgiuste/base:flask