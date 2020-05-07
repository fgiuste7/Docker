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
RUN apt-get update && apt-get install -yq uwsgi gunicorn

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

# uwsgi: https://uwsgi-docs.readthedocs.io/en/latest/WSGIquickstart.html?highlight=flask#deploying-flask
# CMD [uwsgi --socket 0.0.0.0:3031 --wsgi-file /apps/Application/__init__.py --callable app --processes 4 --threads 2 --stats 0.0.0.0:9191]
# uwsgi v2: https://flask.palletsprojects.com/en/1.1.x/deploying/uwsgi/
# CMD ["uwsgi", "--socket", "0.0.0.0:3031", "--manage-script-name", "--mount", "/=/apps/Application:app"]

#------------------
# Login as mainuser
#------------------
USER mainuser