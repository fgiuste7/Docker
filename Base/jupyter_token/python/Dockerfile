# 6/12/2019 (FG)
# fgiuste/base:python
#--------------
# OS: Ubuntu 18
#--------------
FROM fgiuste/base:jupyter_token

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
    && echo 'pip install -r /env/requirements.txt' >> $ENTRYPOINT \
    && echo 'exec "$@"' >> $ENTRYPOINT


#------------------------
# Login as user: mainuser
#------------------------
USER mainuser
WORKDIR /home/mainuser
