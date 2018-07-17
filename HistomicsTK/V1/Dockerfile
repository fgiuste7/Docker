# neuro (FG): HistomicsTK
# 
# To Build Docker Image:
# cd ${Dockerfile_Directory}
# docker build --tag ${image_name} .

#----------------------------------------------------------
# Original Neuro Dockerfiles from: Neurodocker
# https://github.com/kaczmarj/neurodocker
#----------------------------------------------------------
FROM dsarchive/histomicstk:latest


#----------------------------------
# Change Folder Permissions as root
#----------------------------------
USER root

RUN mkdir /app && chmod -R 777 /app
RUN mkdir /output && chmod -R 777 /output
RUN mkdir /data && chmod -R 777 /data
RUN chmod -R 777 /HistomicsTK


#----------------------------------------------
# Define ROOT password: Docker!
#----------------------------------------------
USER root

RUN echo "root:Docker!" | chpasswd


#----------------------------------------------
# Create new user: neuro
#----------------------------------------------
USER root

RUN useradd --no-user-group --create-home --shell /bin/bash neuro
RUN chmod -R 777 /home && chmod a+s /home
RUN chmod 777 /opt && chmod a+s /opt 

USER neuro

ENV PROFILE='/home/neuro/.profile'
RUN echo "alias ls='ls -lha --color=auto' " >> $PROFILE
RUN echo "alias rm='rm -i' " >> $PROFILE

#---------------
# Jupyter Install
#---------------
USER root
RUN pip install --no-cache-dir jupyter

#---------------
# Jupyter Setup
#---------------
USER root

# BASH: Allows Jupyter to run:
RUN mkdir -p /home/neuro/.jupyter \
    && echo c.NotebookApp.ip = \"0.0.0.0\" > /home/neuro/.jupyter/jupyter_notebook_config.py

# BASH: Set notebook password:
RUN echo "{\"NotebookApp\": \
    { \"password\": \"sha1:317d49d226c9:09f54bfd5868c8897e261a281fa9b7fea8904c5d\" } } \
    " >> /home/neuro/.jupyter/jupyter_notebook_config.json

#--------------------
# Redefine Entrypoint
#--------------------
USER neuro

ENTRYPOINT ["/bin/bash"]

