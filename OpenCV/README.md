# https://www.pyimagesearch.com/2018/05/28/ubuntu-18-04-how-to-install-opencv/

cmake -DCMAKE_INSTALL_PREFIX=/home/OpenCV/ -DPYTHON3_EXECUTABLE=/home/bob/miniconda3/bin/python -DPYTHON_INCLUDE_DIR=/home/bob/miniconda3/include/python3.7m/ -DPYTHON_LIBRARY=/home/bob/miniconda3/lib/libpython3.7m.so -DOPENCV_ENABLE_NONFREE:BOOL=ON -DOPENCV_EXTRA_MODULES_PATH=/home/bob/Code/Github/Docker/OpenCV/opencv_contrib/modules ../

sudo make install

git clone https://github.com/opencv/opencv_extra.git

OPENCV_TEST_DATA_PATH=/home/bob/Code/Github/Docker/OpenCV/opencv_extra/testdata

# Python Test SURF/SIFT #
image= np.random.rand( 256,256 )*10
image = image.astype(np.uint8)
sift=cv2.xfeatures2d.SIFT_create()
sift.detectAndCompute(image, None)