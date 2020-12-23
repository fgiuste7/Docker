# 5/7/2019
# Felipe Giuste
#----------------------------------
# Inherits: python:3.8.2-buster   |
#----------------------------------
FROM python:3.8.2


#--------------------------------------------
# Install common dependencies (+screen +tree)
#--------------------------------------------
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
    xauth \
    xterm \
    && apt-get update -qq \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && localedef --force --inputfile=en_US --charmap=UTF-8 C.UTF-8 


#----------------------------------------
# Install Text Editors (+vim +nano +less)
#----------------------------------------
USER root
RUN apt-get update -qq \
    && apt-get install -y -q --no-install-recommends vim \
    nano \
    less \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


#--------------------------
# Create new user: mainuser
#--------------------------
USER root
ENV USR_HOME="/home/mainuser"
RUN useradd --no-user-group --create-home --shell /bin/bash mainuser


#--------------------------
# install flask, flask-cors
#--------------------------
USER root 
RUN pip install flask
RUN pip install flask-cors


#-------------------------
# Install uwsgi + gunicorn
#-------------------------
USER root
RUN apt-get update && apt-get install -yq gunicorn 
RUN pip install uwsgi #uwsgi-plugin-python


# ---------------------------------------------
# Install python packages from requirements.txt
# requirements.txt within /apps/
#----------------------------------------------
USER mainuser
ENTRYPOINT ["pip", "install", "--no-cache-dir", "-r", "/apps/requirements.txt"]


#-----------------------------------
# Create Default Entrypoint
# Install requirements.txt if exists
#-----------------------------------
USER root
ENV ENTRYPOINT="/home/startup.sh"

RUN echo '#!/bin/bash' > ${ENTRYPOINT} \
    && echo 'set +x' >> ${ENTRYPOINT} \
    && echo 'if [ -f "/apps/requirements.txt" ]; then pip install --no-cache-dir -r /apps/requirements.txt; fi' >> ${ENTRYPOINT} \
    && echo 'exec "$@"' >> ${ENTRYPOINT}

ENTRYPOINT ["/home/startup.sh"]


#------------------------------------
# Setup /output and /data directories
#------------------------------------
USER root
RUN mkdir -p /apps && chmod -R 777 /apps
RUN mkdir -p /data && chmod -R 777 /data
RUN mkdir -p /output && chmod -R 777 /output
RUN chmod -R 777 /usr/local/lib/python3.8/site-packages
RUN chmod -R 777 /usr/local/bin
RUN chmod -R 777 /home


#---------------------
# Flask: run routes.py
# host='0.0.0.0'
#---------------------
USER mainuser
# CMD ["python", "/apps/routes.py"]


#------------------------------------------
# Gunicorn / UWSGI: Python WSGI HTTP Server
#------------------------------------------
USER mainuser
WORKDIR /apps/

### Gunicorn ###
# CMD ["gunicorn", "Application:app", "-b", "0.0.0.0:8888"]

### UWSGI ###
# uwsgi: https://uwsgi-docs.readthedocs.io/en/latest/WSGIquickstart.html?highlight=flask#deploying-flask
CMD ["uwsgi", "--http", "0.0.0.0:3031", "-b", "21573", "--wsgi-file", "/apps/routes.py", "--callable", "app", "--processes", "4", "--threads", "2", "--stats", "0.0.0.0:9191"]
### uwsgi --plugin python --socket 0.0.0.0:3031 -b 21573 --wsgi-file /apps/routes.py --callable app --processes 4 --threads 2 --stats 0.0.0.0:9191

# socket instead of http if using nginx
# --plugin python if installing with apt-get

# uwsgi v2: https://flask.palletsprojects.com/en/1.1.x/deploying/uwsgi/
# CMD ["uwsgi", "--socket", "0.0.0.0:3031", "--manage-script-name", "--mount", "/=/apps/Application:app"]


# ------------------------------------
# Port 5000 should be mapped onto host
#-------------------------------------
EXPOSE 5000

### Gunicorn ###
EXPOSE 8888

### UWSGI ###
EXPOSE 3031
EXPOSE 9191


#------------------
# Login as mainuser
#------------------
USER mainuser


#------------
# How to run:
#------------
# docker run -it --rm -v ${PWD}/:/apps/:rw -v ${PWD}/requirements.txt:/apps/requirements.txt:rw -p{external_port}:5000 fgiuste/flask:test bash
# docker run -it --rm -v ${PWD}/:/apps/:rw -p{external_port}:5000 fgiuste/flask:production bash
