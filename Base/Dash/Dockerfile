# 6/04/2019 (FG)
# Felipe Giuste
# Dash Image
# fgiuste/base:dash

FROM fgiuste/base:jupyter_token

#-----------------------
# Conda Install Packages
#-----------------------
USER mainuser

RUN conda config --add channels conda-forge 
RUN conda config --add channels anaconda

RUN conda install   dask \
                    zarr \
                    ipywidgets

#---------------------
# Pip Install Packages
#---------------------
RUN pip install     dash==0.43.0 \
                    dash-daq==0.1.0

#------------------
# Login as mainuser
#------------------
USER mainuser