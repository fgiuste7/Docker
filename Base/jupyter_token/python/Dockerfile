# 6/12/2019 (FG)
# fgiuste/base:python
#--------------
# OS: Ubuntu 18
#--------------
FROM fgiuste/base:jupyter_token


#-----------------
# Initialize conda
#-----------------
USER root
RUN apt-get update && apt-get install -yqq build-essential


#--------------------------------------
# Create Directory for requirements.txt
#--------------------------------------
USER root
RUN mkdir -m777  /env


#-----------------
# Initialize conda
#-----------------
USER mainuser
RUN conda init bash


#--------------------
# Python requirements
#--------------------
USER root
ENV BASHRC /home/mainuser/.bashrc

RUN echo '#!/bin/bash' > $ENTRYPOINT \
    && echo 'set +x' >> $ENTRYPOINT \
    && echo 'exec "$@"' >> $ENTRYPOINT
#     && echo 'pip install -r /env/requirements.txt' >> $ENTRYPOINT \ #(before last line)

#----------------------------------
# Define ROOT password: FOR TESTING
#----------------------------------
#USER root
#RUN echo "root:Docker!" | chpasswd


#------------------------
# Login as user: mainuser
#------------------------
USER mainuser
WORKDIR /home/mainuser
