# neuro (FG): HistomicsTK
# 
# To Build Docker Image:
# cd ${Dockerfile_Directory}
# docker build --tag ${image_name} .

#----------------------------------------------------------
# Original Neuro Dockerfiles from: Neurodocker
# https://github.com/kaczmarj/neurodocker
#----------------------------------------------------------
FROM fgiuste/histomicstk:V2


#----------------------------------
# Change Folder Permissions as root
#----------------------------------
USER root

RUN chmod -R 777 /home && chmod a+s /home

#---------------
# install girder
#---------------
USER root

RUN pip install --no-cache-dir girder girder-client

#----------------
# install pymongo
#----------------
USER root

RUN pip install --no-cache-dir pymongo pycap

#---------------
# Login as neuro
#---------------
USER neuro
