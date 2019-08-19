# 12/28/2018 (FG)
# fgiuste/flask:test
#------------------------------------------------
# Inherits: fgiuste/base:flask                  |
# From ubuntu:18.04                             |
#------------------------------------------------
FROM fgiuste/base:flask

#----------------------------
# Add scripts to final image:
# Copies contents of test_app into /apps/
#----------------------------------------
USER root
ADD [--chown=mainuser] test_app/ /apps/

#-------------------
# Login as mainuser
#-------------------
USER mainuser