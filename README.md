# Docker
## Neuro Image Contains:
Miniconda
Nipype
FSL
dask, dash, plotly, matplotlib, scikit, jupyter, nibabel
And others

## To Download prebuilt image:
docker pull fgiuste/neuro

## To build image from Dockerfile (Dockerfile must be in . and named "Dockerfile"):
docker build --tag neuro .
