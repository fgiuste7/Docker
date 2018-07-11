docker run --rm kaczmarj/neurodocker:0.4.0 generate docker \
    --base debian:stretch --pkg-manager apt \
    --ants version=2.2.0 method=binaries \
    --afni version=latest method=binaries \
    --convert3d version=1.0.0 method=binaries \
    --freesurfer version=6.0.0 method=binaries \
    --fsl version=5.0.10 method=binaries \
    --minc version=1.9.15 method=binaries \
    --dcm2niix version=latest method=source \
    --miniconda create_env=neuro conda_install='python=3.6 numpy pandas traits' pip_install='nipype' \
    --miniconda use_env=neuro conda_install='jupyter' \
    --mrtrix3 version=3.0 \
    --neurodebian os_codename=stretch server=usa-nh \
  	--install fsl-core \
  	--petpvc version=1.2.2 method=binaries > Dockerfile

#----------------------------------------------
# Change Folder Permissions as root
#----------------------------------------------
USER root

# BASH: Allows Jupyter to run:
RUN mkdir -p /neurodocker/.jupyter \
    && echo c.NotebookApp.ip = \"0.0.0.0\" > /neurodocker/.jupyter/jupyter_notebook_config.py

# BASH: Set notebook password:
RUN echo "{\"NotebookApp\": \
    { \"password\": \"sha1:317d49d226c9:09f54bfd5868c8897e261a281fa9b7fea8904c5d\" } } \
    " >> /neurodocker/.jupyter/jupyter_notebook_config.json

# Change file permissions
RUN chmod -R 777 /etc/fsl
RUN chmod -R 777 /neurodocker/
RUN mkdir /data && chmod -R 777 /data
RUN mkdir /output && chmod -R 777 /output
RUN chmod 777 /neurodocker/startup.sh