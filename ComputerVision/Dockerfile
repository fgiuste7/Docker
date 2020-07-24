# Created: 02/18/2020 (FG)
# Updated: 07/24/2020 (FG)
# fgiuste/computervision
#----------------------------
# Inherits: fgiuste/base:base
# OS: Ubuntu 18             
#----------------------------
FROM fgiuste/ml:latest

#----------------------
# Install Dependencies:
#----------------------
USER root
RUN apt-get update && apt-get install -yq --no-install-recommends build-essential
RUN apt-get install -yq --no-install-recommends wget cmake git libgtk2.0-dev pkg-config libavcodec-dev libavformat-dev libswscale-dev
RUN apt-get install -yq --no-install-recommends python-dev python-numpy libtbb2 libtbb-dev libjpeg-dev libpng-dev libtiff-dev 

#-----------------
# Download OpenCV:
#-----------------
USER root
RUN mkdir /openCV && chmod -R 777 /openCV
WORKDIR /openCV
RUN wget -O opencv.zip https://github.com/opencv/opencv/archive/3.4.9.zip
RUN wget -O opencv_contrib.zip https://github.com/opencv/opencv_contrib/archive/3.4.9.zip 
RUN unzip opencv.zip && mv opencv-3.4.9 opencv
RUN unzip opencv_contrib.zip && mv opencv_contrib-3.4.9 opencv_contrib

WORKDIR opencv
RUN mkdir build
WORKDIR build

RUN cmake -D CMAKE_BUILD_TYPE=RELEASE \
    -D CMAKE_INSTALL_PREFIX=/usr/local \
    -D PYTHON3_EXECUTABLE=/usr/local/bin/python \
    -D PYTHON_INCLUDE_DIR=/usr/include/python3.6m \
    -D PYTHON_LIBRARY=/usr/lib/x86_64-linux-gnu/libpython3.6m.so \
    -D INSTALL_PYTHON_EXAMPLES=ON \
    -D OPENCV_EXTRA_MODULES_PATH=/openCV/opencv_contrib/modules \
    -D OPENCV_ENABLE_NONFREE=ON \
    -D BUILD_EXAMPLES=ON ..

RUN make -j7
RUN make install

#------------------
# PyTorch
#------------------
USER root
RUN pip install torch==1.5.1+cu101 torchvision==0.6.1+cu101 -f https://download.pytorch.org/whl/torch_stable.html

#------------------
# Install WSI packages:
# large-image 
# openslide
# HistomicsTK
#------------------
USER root
RUN apt-get update && apt-get install -yq python3-openslide
RUN pip install large-image[all] --find-links https://girder.github.io/large_image_wheels
RUN pip install histomicstk --find-links https://girder.github.io/large_image_wheels

#----------------
# Install dask:
#----------------
USER root
RUN pip install --no-cache-dir "dask[complete]"==2.21.0

#---------------
# Install zarr:
#---------------
USER root
RUN pip install --no-cache-dir zarr==2.4.0

#------------------
# Login as mainuser
#------------------
USER mainuser
WORKDIR /home/mainuser

