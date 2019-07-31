# 5/17/2019 (FG), Modified 6/30/2019 (FG)
# Felipe Giuste
# Neuroimaging Base Image with Freesurfer 6.0.1
# fgiuste/base:freesurfer

FROM fgiuste/base:neuroimaging


#-------------------
# Freesurfer Install
# https://surfer.nmr.mgh.harvard.edu/fswiki/DownloadAndInstall
# Obtain individual license: 
# https://surfer.nmr.mgh.harvard.edu/registration.html
#-------------------
USER root

# Freeview dependencies:
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
RUN wget https://surfer.nmr.mgh.harvard.edu/pub/dist/freesurfer/6.0.1/freesurfer-Linux-centos6_x86_64-stable-pub-v6.0.1.tar.gz
RUN tar -C /usr/local -xzvf freesurfer-Linux-centos6_x86_64-stable-pub-v6.0.1.tar.gz && rm freesurfer-Linux-centos6_x86_64-stable-pub-v6.0.1.tar.gz

RUN sed -i '$iexport FREESURFER_HOME=/usr/local/freesurfer' $ENTRYPOINT
RUN sed -i '$isource $FREESURFER_HOME/SetUpFreeSurfer.sh' $ENTRYPOINT


# Tutorial data: ~8GB
# http://surfer.nmr.mgh.harvard.edu/fswiki/FsTutorial/Data
#RUN curl https://surfer.nmr.mgh.harvard.edu/pub/data/tutorial_data.tar.gz -o tutorial_data.tar.gz
#RUN tar -xzvf tutorial_data.tar.gz
#RUN rm tutorial_data.tar.gz
#ENV TUTORIAL_DATA=/path/to/your/tutorial/dir


#-------------------
# Permissions
#-------------------
USER root
RUN chmod 777 -R /usr/local/freesurfer/subjects

#---------------------
# Login as user: mainuser
#---------------------
USER mainuser