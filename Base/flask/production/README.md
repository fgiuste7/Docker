# Run Flask App with Docker Container ( fgiuste/flask:production ):
## CMD is: python /apps/run.py

## docker run --rm -v ${PWD}:/apps/:rw -p 8888:8888 fgiuste/flask:production

# Flask Application layout:
- run.py
- Application/
-   __init__.py
-   routes.py
-   templates/

## Note: run.py not used by gunicorn or uwsgi
## Default WSGI Server is gunicorn