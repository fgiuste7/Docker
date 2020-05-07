# 4/4/2019 (FG)
#-----------------------------------
# Inherits: python:2.7.16-jessie   |
#-----------------------------------
FROM python:2.7.16-jessie

#---------------------------
# install flask, flask-cors:
#---------------------------
RUN pip install flask
RUN pip install flask-cors

#---------------------------
# Add application to /apps/:
# Copies contents of current directory into /apps/
#-------------------------------------------------
COPY requirements.txt /apps/
COPY Register_docker.py /apps/

# ----------------------------------------------
# Install python packages from requirements.txt:
# requirements.txt within /apps/
#-----------------------------------------------
RUN pip install --no-cache-dir -r /apps/requirements.txt

# ------------------------------------
# Setup /output and /data directories:
#-------------------------------------
RUN mkdir /data && chmod -R 777 /data
RUN mkdir /output && chmod -R 777 /output

#-------------------
# run flask_app.py :
# host='0.0.0.0'
#-------------------
CMD ["python", "/apps/flask_app.py"]

# -------------------------------------
# Port 5000 should be mapped onto host:
#--------------------------------------
EXPOSE 5000

#--------------
# How to build:
#--------------
# Within application directory (with requirements.txt. Dockerfile, and any other necessary files):
# docker build --tag appname .

#------------
# How to run:
#------------
# docker run --rm -p5000:5000 appname
