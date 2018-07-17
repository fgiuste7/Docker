# neuro (FG): HistomicsTK
# 
# To Build Docker Image:
# cd ${Dockerfile_Directory}
# docker build --tag ${image_name} .

#----------------------------------------------------------
# Original Neuro Dockerfiles from: Neurodocker
# https://github.com/kaczmarj/neurodocker
#----------------------------------------------------------
FROM fgiuste/histomicstk:V1


#----------------------------------
# Change Folder Permissions as root
#----------------------------------
USER root

RUN chmod -R 777 /home && chmod a+s /home

#---------------
# install screen
#---------------
USER root

RUN apt-get update -qq \
    && apt-get install -y -q --no-install-recommends screen \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

#---------------
# Login as neuro
#---------------
USER neuro
