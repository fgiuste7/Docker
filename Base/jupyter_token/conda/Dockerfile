# 6/12/2019 (FG)
# fgiuste/base:conda
#--------------
# OS: Ubuntu 18
#--------------
FROM fgiuste/base:jupyter_token

#--------------------------------------------
# Create Directory for conda requirements.txt
#--------------------------------------------
USER root
RUN mkdir -m777  /env


#--------------------------------------------
# Create Directory for conda requirements.txt
#--------------------------------------------
USER mainuser
CMD [ "conda", "create", "--name", "myenv", "--file", "/env/requirements.txt" ]


#------------------------
# Login as user: mainuser
#------------------------
USER mainuser
WORKDIR /home/mainuser
