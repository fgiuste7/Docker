# 1/31/2020
# Felipe Giuste
# IntraAnat
# fgiuste/intranat:latest


#------------------------------------------------
# Description:
# Matlab Runtime image on Ubuntu 18
# Creates user: mainuser
# Creates Directories for organized mounting
# ENTRYPOINT ["/home/startup.sh"]
# CMD ["/bin/bash"]
#------------------------------------------------

FROM demanp/intranat:release2

#----------------------------------
# Define ROOT password: FOR TESTING
#----------------------------------
USER root
RUN echo "root:Docker!" | chpasswd
RUN usermod -aG sudo manik
RUN echo 'manik:Docker' | chpasswd
RUN apt-get update 
RUN apt-get install -y software-properties-common
RUN add-apt-repository ppa:ubuntu-toolchain-r/test
RUN apt-get update && apt-get install -y gcc-4.9 && apt-get upgrade -y libstdc++6
RUN chmod 777 -R /home/user


#-------------------
# Add matlab to PATH
#-------------------
USER manik
RUN PATH=${PATH}:/usr/local/MATLAB/from-host/bin/


