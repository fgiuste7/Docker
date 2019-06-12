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


#---------------------
# initialize conda env
#---------------------
USER mainuser
RUN conda init bash


#-----------------
# Setup ENTRYPOINT
#-----------------
USER root
RUN echo '#!/bin/bash' > $ENTRYPOINT \
    && echo 'set +x' >> $ENTRYPOINT \
    && echo 'source /home/mainuser/.bashrc' >> $ENTRYPOINT 
    #&& echo 'conda create -y --name myenv --file /env/requirements.txt' >> $ENTRYPOINT \
    #&& echo "conda activate myenv" >> $ENTRYPOINT 
    #&& echo 'exec "$@"' >> $ENTRYPOINT

CMD [ "/bin/bash" ]

#------------------------
# Login as user: mainuser
#------------------------
USER mainuser
WORKDIR /home/mainuser
