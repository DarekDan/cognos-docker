FROM ubuntu:20.04 AS cognos-base
SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN groupadd -r cognos --gid=999
RUN useradd -rm -g cognos --uid=999 -d /home/cognos -s /bin/bash -G sudo cognos 
RUN echo "cognos:cognos" | chpasswd 
RUN apt-get -y update

# Dependencies
RUN apt-get -qq install openssh-server sudo nano vim-tiny
RUN apt-get -qq install unzip libc6:amd64 libstdc++6 libxtst6 libxi6 libxft2
RUN apt-get -qq clean

# Configure SSHD.
# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
RUN mkdir /var/run/sshd
RUN bash -c 'install -m755 <(printf "#!/bin/sh\nexit 0") /usr/sbin/policy-rc.d'
RUN ex +'%s/^#\zeListenAddress/\1/g' -scwq /etc/ssh/sshd_config
RUN ex +'%s/^#\zeHostKey .*ssh_host_.*_key/\1/g' -scwq /etc/ssh/sshd_config
RUN RUNLEVEL=1 dpkg-reconfigure openssh-server
RUN ssh-keygen -A -v
RUN update-rc.d ssh defaults

# Configure sudo.
RUN ex +"%s/^%sudo.*$/%sudo ALL=(ALL:ALL) NOPASSWD:ALL/g" -scwq! /etc/sudoers

# Generate and configure user keys.
USER cognos
RUN ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519

# Setup default command and/or parameters.
EXPOSE 22
CMD ["/usr/bin/sudo", "/usr/sbin/sshd", "-D", "-o", "ListenAddress=0.0.0.0"]


FROM cognos-base AS cognos-dispatcher
USER root
RUN mkdir /opt/cognos && chown cognos:cognos /opt/cognos
USER cognos
WORKDIR /home/cognos
