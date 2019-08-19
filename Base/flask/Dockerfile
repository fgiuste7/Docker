# 12/27/2018 (FG)
# fgiuste/base:flask
#--------------
# OS: Ubuntu 18
#--------------

#------------------------------------------------
# Inherits: fgiuste/base:flask                  |
# From ubuntu:18.04                             |
#------------------------------------------------
FROM fgiuste/base:base

#------------
# install pip
#------------
USER root
RUN apt-get update && apt-get install -y python-pip

#--------------
# install flask
#--------------
USER mainuser
RUN pip install flask

# ------------------
# install flask-cors
#-------------------
USER mainuser
RUN pip install flask-cors

#---------------
# run flask app:
# host='0.0.0.0'
#---------------
USER mainuser
CMD ["python", "/apps/run.py"]

#------------------
# Login as mainuser
#------------------
USER mainuser

#------------
# How to run:
#------------
# within directory containing run.py and app class (app folder containing __init__.py + routes.py)
# docker run --rm -p8081:8888 -v ${PWD}:/apps/:rw fgiuste/base:flask
