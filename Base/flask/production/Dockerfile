# 7/31/2019 (FG)
# fgiuste/flask:production
#--------------------------------
# Inherits: fgiuste/base:flask  |
# OS: Ubuntu 18                 |
#--------------------------------
FROM fgiuste/base:flask

#-------------------------
# Install uwsgi + gunicorn
#-------------------------
USER root
RUN apt-get install -yq uwsgi
RUN apt-get install -yq gunicorn

#----------------
# Install pymongo
#----------------
USER mainuser
RUN pip install pymongo

#----------------------------
# Add scripts to final image:
# Copies contents of . into /apps/
#----------------------------------------
USER root
#ADD [--chown=mainuser] . /apps/

#----------------------------------
# Gunicorn: Python WSGI HTTP Server
#----------------------------------
USER mainuser
WORKDIR /apps/
CMD ["gunicorn", "Application:app", "-b", "0.0.0.0:8888"]

#------------------
# Login as mainuser
#------------------
USER mainuser