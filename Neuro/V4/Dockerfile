# neuro (FG): V4
# 
# To Build Docker Image:
# cd ${Dockerfile_Directory}
# docker build --tag ${image_name} .

#----------------------------------------------------------
# Original Neuro Dockerfiles from: Neurodocker
# https://github.com/kaczmarj/neurodocker
#----------------------------------------------------------
FROM fgiuste/neuro:V3

#------------------
# Install niwidgets
#------------------
USER root
RUN pip install --no-cache-dir niwidgets nilearn

#-------------------------------------------
# Create /code/scripts/ and /code/notebooks/
#-------------------------------------------
USER root

RUN mkdir -p /code/scripts \
    && mkdir -p /code/notebooks \
    && chmod -R 777 /code

#----------------------
# Switch to user: neuro
#----------------------
USER neuro