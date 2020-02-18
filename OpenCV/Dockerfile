# Created: 2/18/2020 (FG)
# fgiuste/opencv
#----------------------------
# Inherits: fgiuste/base:base
# OS: Ubuntu 18             
#----------------------------
FROM fgiuste/base:base


#----------------------
# Install Dependencies:
#----------------------
USER root
RUN apt-get install build-essential
RUN apt-get install cmake git libgtk2.0-dev pkg-config libavcodec-dev libavformat-dev libswscale-dev
RUN apt-get install python-dev python-numpy libtbb2 libtbb-dev libjpeg-dev libpng-dev libtiff-dev libjasper-dev libdc1394-22-dev

#-----------------
# Download OpenCV:
#-----------------
RUN mkdir /openCV && chmod -R 777 /openCV
CWD /openCV
RUN git clone https://github.com/opencv/opencv.git







