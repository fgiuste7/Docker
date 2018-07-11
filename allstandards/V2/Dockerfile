# 7/2/2018 (FG)
# 
# To Build Docker Image:
# cd ${Dockerfile_Directory}
# docker build --tag ${image_name} .

#----------------------------------------------------------
# Install allstandards
#----------------------------------------------------------
FROM fgiuste/allstandards:V1 

#----------------------------------------------------------
# Install common dependencies and create default entrypoint
#----------------------------------------------------------
ENV LANG="en_US.UTF-8" \
LC_ALL="C.UTF-8" \
ND_ENTRYPOINT="/home/startup.sh"

RUN apt-get update -qq && apt-get install -yq --no-install-recommends \
      apt-utils ca-certificates curl locales unzip sudo gnupg dirmngr \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && localedef --force --inputfile=en_US --charmap=UTF-8 C.UTF-8 \
    && chmod 777 /opt && chmod a+s /opt \
    && if [ ! -f "$ND_ENTRYPOINT" ]; then \
         echo '#!/usr/bin/env bash' >> $ND_ENTRYPOINT \
         && echo 'set +x' >> $ND_ENTRYPOINT \
         && echo 'if [ -z "$*" ]; then /usr/bin/env bash; else $*; fi' >> $ND_ENTRYPOINT; \
       fi \
    && chmod -R 777 /home && chmod a+s /home

ENTRYPOINT ["/home/startup.sh"]
RUN sed -i '$isource /etc/fsl/fsl.sh' $ND_ENTRYPOINT

#----------------------------------------------
# Create new user: neuro
#----------------------------------------------
RUN useradd --no-user-group --create-home --shell /bin/bash neuro
USER neuro

ENV PROFILE='/home/neuro/.profile'
RUN echo "$isource /etc/fsl/fsl.sh" >> $PROFILE
RUN echo "alias ls='ls -lha --color=auto' " >> $PROFILE
RUN echo "alias rm='rm -i' " >> $PROFILE

#------------------
# Install Miniconda
#------------------
ENV CONDA_DIR=/opt/conda \
    PATH=/opt/conda/bin:$PATH
RUN echo "Downloading Miniconda installer ..." \
    && miniconda_installer=/tmp/miniconda.sh \
    && curl -sSL --retry 5 -o $miniconda_installer https://repo.continuum.io/miniconda/Miniconda3-4.3.31-Linux-x86_64.sh \
    && /bin/bash $miniconda_installer -b -p $CONDA_DIR \
    && rm -f $miniconda_installer \
    && conda config --system --prepend channels conda-forge \
    && conda config --system --set auto_update_conda false \
    && conda config --system --set show_channel_urls true \
    && conda clean -tipsy && sync

#-------------------------
# Conda Install
#-------------------------
RUN conda install -y pytest \
                     jupyter \
                     traits \
                     pandas \
                     matplotlib \
                     scikit-learn \
                     scikit-image \
                     seaborn \
                     nbformat \
                     nb_conda \
                     ipywidgets \
                     plotly \
                     dash \
                     dash-renderer \
                     dash-html-components \
                     dash-core-components \
                     nibabel \
                     scipy \
                     graphviz \
                     python-graphviz \
                     networkx \
                     pydot \
                     dask \
                     h5py \
                     pytables \
                     zarr \
    && sync && conda clean -tipsy && sync \
    && pip install --no-cache-dir https://github.com/nipy/nipype/tarball/master \
                                  https://github.com/INCF/pybids/tarball/master \
                                  nilearn \
                                  datalad[full] \
                                  nipy \
                                  duecredit \
                                  itkwidgets \
                                  itk-io \
                                  pysurfer \
                                  mayavi \
    && sync


#----------------------------------------------
# Change Folder Permissions as root
#----------------------------------------------
USER root

# BASH: Allows Jupyter to run:
RUN mkdir -p /home/neuro/.jupyter \
    && echo c.NotebookApp.ip = \"0.0.0.0\" > /home/neuro/.jupyter/jupyter_notebook_config.py

# BASH: Set notebook password:
RUN echo "{\"NotebookApp\": \
    { \"password\": \"sha1:317d49d226c9:09f54bfd5868c8897e261a281fa9b7fea8904c5d\" } } \
    " >> /home/neuro/.jupyter/jupyter_notebook_config.json

# Change file permissions
RUN chmod -R 777 /etc/fsl
RUN chmod -R 777 /home/neuro
RUN mkdir /data && chmod -R 777 /data
RUN mkdir /output && chmod -R 777 /output
RUN chmod 777 /home/startup.sh


#----------------------------------------------
# Define ROOT password: Docker!
#----------------------------------------------
RUN echo "root:Docker!" | chpasswd

# BASH
RUN bash -c "rm -rf /opt/conda/pkgs/*"


#----------------------------------------------
# Login as user: neuro
#----------------------------------------------
USER neuro
WORKDIR /home/neuro
RUN /home/neuro/.profile
