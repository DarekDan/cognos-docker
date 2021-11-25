FROM ubuntu:20.04
RUN groupadd -r cognos --gid=999 && useradd -r -g cognos --uid=999 cognos

RUN apt-get -y update

RUN apt-get install -y openssh-server  

RUN apt-get install -y unzip libc6:amd64 libstdc++6 libxtst6 libxi6 libxft2
RUN mkdir /opt/cognos && chown cognos:cognos /opt/cognos
