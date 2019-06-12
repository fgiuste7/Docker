# 6/12/2019 (FG)
# fgiuste/base:conda
#--------------
# OS: Ubuntu 18
#--------------
FROM fgiuste/base:jupyter

#--------------------------------------------
# Create Directory for conda requirements.txt
#--------------------------------------------
USER root
RUN mkdir -m777  /env


#-----------------
# Setup ENTRYPOINT
#-----------------
USER root
RUN echo '#!/usr/bin/env bash' >> $ENTRYPOINT \
    && echo 'set +x' >> $ENTRYPOINT \
    && echo 'conda create --name myenv --file /env/requirements.txt' >> $ENTRYPOINT \
    && echo "conda activate myenv" >> $ENTRYPOINT \
    && echo 'exec "$@"' >> $ENTRYPOINT


#------------------------
# Login as user: mainuser
#------------------------
USER mainuser
WORKDIR /home/mainuser
