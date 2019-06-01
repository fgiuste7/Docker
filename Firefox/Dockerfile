FROM ubuntu:18.04

USER root
RUN apt-get update && apt-get install -qy firefox xterm xauth iputils-ping vim
RUN useradd -l -ms /bin/bash ff
RUN chown -R ff /home/ff
RUN chmod -R 777 /home/ff

USER ff
WORKDIR /home/ff
RUN touch /home/ff/.Xauthority

CMD ["bash"]
