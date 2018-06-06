# neuroML (FG)
# 
# To Build Docker Image:
# cd ${Dockerfile_Directory}
# docker build --tag ${image_name} .

#----------------------------------------------------------
# Original Dockerfile from: 
# https://github.com/jupyter/docker-stacks/blob/master/tensorflow-notebook/Dockerfile
#----------------------------------------------------------
# This version adds:
# Girder
#----------------------------------------------------------

FROM jupyter/scipy-notebook

RUN conda create -y -q --name neuro python=2.7 \
    && sync && conda clean -tipsy && sync \
    && /bin/bash -c "source activate neuro \
    && pip install -q --no-cache-dir girder"

#----------------------------------------------------------
# Create Jupyter Notebook Password
#----------------------------------------------------------
RUN echo "{\"NotebookApp\": \
    { \"password\": \"sha1:317d49d226c9:09f54bfd5868c8897e261a281fa9b7fea8904c5d\" } } \
    " >> /home/neuro/.jupyter/jupyter_notebook_config.json



import girder_client
gc = girder_client.GirderClient(apiUrl='http://candygram.neurology.emory.edu:8080/api/v1')