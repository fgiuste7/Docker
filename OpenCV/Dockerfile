# Created: 2/18/2020 (FG)
# fgiuste/opencv
#----------------------------
# Inherits: fgiuste/base:base
# OS: Ubuntu 18             
#----------------------------
FROM fgiuste/base:jupyter_token


#----------------------
# Install Dependencies:
#----------------------
USER root
RUN apt-get update && apt-get install -yq --no-install-recommends build-essential
RUN apt-get install -yq --no-install-recommends cmake git libgtk2.0-dev pkg-config libavcodec-dev libavformat-dev libswscale-dev
RUN apt-get install -yq --no-install-recommends python-dev python-numpy libtbb2 libtbb-dev libjpeg-dev libpng-dev libtiff-dev 


#-----------------
# Download OpenCV:
#-----------------
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
    -D CMAKE_INSTALL_PREFIX=/opt/conda \
    -D WITH_CUDA=ON \
    -D PYTHON3_EXECUTABLE=/opt/conda/bin/python \
    -D PYTHON_INCLUDE_DIR=/opt/conda/include/python3.7m/ \
    -D PYTHON_LIBRARY=/opt/conda/lib/libpython3.7m.so \
    -D INSTALL_PYTHON_EXAMPLES=ON \
    -D OPENCV_EXTRA_MODULES_PATH=/openCV/opencv_contrib/modules \
    -D OPENCV_ENABLE_NONFREE=ON \
    -D BUILD_EXAMPLES=ON ..

RUN make -j6
RUN make install

# SIFT: sift=cv2.xfeatures2d.SIFT_create()
# SURF: surf=cv2.xfeatures2d.SURF_create()







