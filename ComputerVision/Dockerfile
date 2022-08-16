# Created: 02/18/2020 (FG)
# Updated: 07/24/2020 (FG)
# Updated: 2022-03-03 (FG)
# Updated: 2022-08-10 (FG)
# fgiuste/computervision

#----------------------------
# Inherits: fgiuste/ml
#----------------------------
FROM fgiuste/ml:latest

#----------------
# Install dask: SKIPPED
#----------------
# USER mainuser
# RUN pip install --user --no-cache-dir "dask[complete]"

#--------------
# Install HDF5: SKIPPED
#--------------
# USER mainuser
# RUN pip install --user --no-cache-dir h5py

#--------------
# Install Zarr: SKIPPED
#--------------
# USER mainuser
# RUN pip install --user --no-cache-dir zarr

#------------
# Jupyter Lab 
#------------
USER mainuser
RUN pip install --user --no-cache-dir --upgrade nbformat
RUN pip install --user --no-cache-dir jupyterlab

#------------------
# SKIPPED
# Install WSI packages:
# large-image 
# openslide
# HistomicsTK
#------------------
# USER root
# RUN apt-get update && apt-get install -yq python3-openslide
# USER mainuser
# RUN pip install large-image[all] --find-links https://girder.github.io/large_image_wheels
# RUN pip install histomicstk --find-links https://girder.github.io/large_image_wheels

#-----------------------------
# Install OpenCV Dependencies: SKIPPED
#-----------------------------
# USER root
# RUN apt-get update && apt-get install -yq --no-install-recommends build-essential
# RUN apt-get install -yq --no-install-recommends wget cmake git libgtk2.0-dev pkg-config libavcodec-dev libavformat-dev libswscale-dev
# RUN apt-get install -yq --no-install-recommends python-dev python-numpy libtbb2 libtbb-dev libjpeg-dev libpng-dev libtiff-dev 

#-----------------
# Download OpenCV:
#-----------------
USER mainuser
RUN pip install --user --no-cache-dir opencv-contrib-python-headless

#RUN mkdir /openCV && chmod -R 777 /openCV
#WORKDIR /openCV
#RUN wget -O opencv.zip https://github.com/opencv/opencv/archive/3.4.9.zip
#RUN wget -O opencv_contrib.zip https://github.com/opencv/opencv_contrib/archive/3.4.9.zip 
#RUN unzip opencv.zip && mv opencv-3.4.9 opencv
#RUN unzip opencv_contrib.zip && mv opencv_contrib-3.4.9 opencv_contrib
#
#WORKDIR opencv
#RUN mkdir build
#WORKDIR build
#
#RUN cmake -D CMAKE_BUILD_TYPE=RELEASE \
#    -D CMAKE_INSTALL_PREFIX=/usr/local \
#    -D PYTHON3_EXECUTABLE=/usr/local/bin/python \
#    -D PYTHON_INCLUDE_DIR=/usr/include/python3.6m \
#    -D PYTHON_LIBRARY=/usr/lib/x86_64-linux-gnu/libpython3.6m.so \
#    -D INSTALL_PYTHON_EXAMPLES=ON \
#    -D OPENCV_EXTRA_MODULES_PATH=/openCV/opencv_contrib/modules \
#    -D OPENCV_ENABLE_NONFREE=ON \
#    -D BUILD_EXAMPLES=ON ..
#
#RUN make -j7
#RUN make install

#-------------------------
# Login as user: mainuser:
#-------------------------
USER mainuser
WORKDIR /home/mainuser

#------------------
# Start Jupyter Lab
#------------------
CMD ["jupyter", "lab", "--notebook-dir=/", "--ip", "0.0.0.0"]

#------------------
# Login as mainuser
#------------------
USER mainuser
WORKDIR /home/mainuser