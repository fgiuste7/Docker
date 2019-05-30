# 5/17/2019 (FG)
# Felipe Giuste
# Neuroimaging Image with Freesurfer
# fgiuste/neuroimaging:freesurfer

FROM fgiuste/neuroimaging


#-------------------
# Freesurfer Install
# https://surfer.nmr.mgh.harvard.edu/fswiki/DownloadAndInstall
# Obtain individual liscence: 
# https://surfer.nmr.mgh.harvard.edu/registration.html
#-------------------
USER root

# Install freeview dependencies:
RUN apt-get update -qq \
    && apt-get install -y -q --no-install-recommends wget \
                                                    xz-utils \
                                                    libglu1 \
                                                    libjpeg62 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN wget -q -O /tmp/libpng12.deb http://mirrors.kernel.org/ubuntu/pool/main/libp/libpng/libpng12-0_1.2.54-1ubuntu1_amd64.deb \
  && dpkg -i /tmp/libpng12.deb \
  && rm /tmp/libpng12.deb

# Freesurfer:
RUN wget https://surfer.nmr.mgh.harvard.edu/pub/dist/freesurfer/6.0.0/freesurfer-Linux-centos6_x86_64-stable-pub-v6.0.0.tar.gz
RUN tar -C /usr/local -xzvf freesurfer-Linux-centos6_x86_64-stable-pub-v6.0.0.tar.gz # && rm freesurfer-Linux-centos6_x86_64-stable-pub-v6.0.0.tar.gz

RUN sed -i '$iexport FREESURFER_HOME=/usr/local/freesurfer' $ENTRYPOINT
RUN sed -i '$isource $FREESURFER_HOME/SetUpFreeSurfer.sh' $ENTRYPOINT


# Tutorial data: ~8GB
# http://surfer.nmr.mgh.harvard.edu/fswiki/FsTutorial/Data
#RUN curl https://surfer.nmr.mgh.harvard.edu/pub/data/tutorial_data.tar.gz -o tutorial_data.tar.gz
#RUN tar -xzvf tutorial_data.tar.gz
#RUN rm tutorial_data.tar.gz
#ENV TUTORIAL_DATA=/path/to/your/tutorial/dir


#---------------------
# Login as user: neuro
#---------------------
USER neuro
WORKDIR /home/neuro
