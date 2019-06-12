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


#-----------------
# Initialize conda
#-----------------
USER mainuser
RUN conda init bash


#-----------------
# Create conda env
#-----------------
USER root
ENV BASHRC /home/mainuser/.bashrc
RUN echo 'conda create -y --name myenv --file /env/requirements.txt' >> $BASHRC \
    && echo "conda activate myenv; echo hello;" >> $BASHRC


#-----------------
# Setup ENTRYPOINT
#-----------------
USER root
RUN echo '#!/bin/bash' > $ENTRYPOINT \
    && echo 'set +x' >> $ENTRYPOINT \
    && echo 'exec "$@"' >> $ENTRYPOINT
    #&& echo 'source /home/mainuser/.bashrc' >> $ENTRYPOINT

CMD ["/bin/bash"]


#------------------------
# Login as user: mainuser
#------------------------
USER mainuser
WORKDIR /home/mainuser
