# 12/28/2018 (FG)
# fgiuste/flask:test
#------------------------------------------------
# Inherits: phusion/baseimage:0.10.2            |
# https://github.com/phusion/baseimage-docker   |
# From Ubuntu 16.04.5                           |
#------------------------------------------------
FROM fgiuste/base:flask

#----------------------------
# Add scripts to final image:
# Copies contents of test_app into /apps/
#----------------------------------------
USER root
ADD [--chown=mainuser] test_app/ /apps/

#---------------------------------------------------
# Login as root: ENTRYPOINT will switch to mainuser:
#---------------------------------------------------
USER root