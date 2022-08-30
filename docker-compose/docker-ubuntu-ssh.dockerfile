FROM ubuntu:20.04
LABEL maintainer "wskyland <wskyland@google.com>"
LABEL title="wskyland Docker"
LABEL version="0.1"
LABEL description="Docker wskyland Label"

ENV USER webcash

# timezone
RUN apt update && apt install -y tzdata; \
    apt clean;
RUN apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

# sshd
RUN mkdir /run/sshd; \
    apt install -y openssh-server; \
    sed -i 's/^#\(PermitRootLogin\) .*/\1 yes/' /etc/ssh/sshd_config; \
    sed -i 's/^\(UsePAM yes\)/# \1/' /etc/ssh/sshd_config; \
    apt clean;

# entrypoint
RUN { \
    echo '#!/bin/bash -eu'; \
    echo 'ln -fs /usr/share/zoneinfo/${TZ} /etc/localtime'; \
    echo 'echo "root:${ROOT_PASSWORD}" | chpasswd'; \
    echo 'exec "$@"'; \
    } > /usr/local/bin/entry_point.sh; \
    chmod +x /usr/local/bin/entry_point.sh;

ENV TZ Asia/Seoul

ENV ROOT_PASSWORD root

#make .ssh
RUN useradd -m $USER
RUN mkdir /home/$USER/.ssh
RUN chown $USER.$USER /home/$USER/.ssh
RUN chmod 700 /home/$USER/.ssh 
 
#set password
RUN echo 'root:root' |chpasswd
RUN echo "${USER}:webcash12!@" |chpasswd

RUN apt-get remove docker docker-engine docker.io containerd runc
RUN apt-get remove docker docker-engine docker.io containerd runc


#RUN pip install --upgrade pip
#RUN pip install --upgrade pip
#RUN pip install pymssql 
#RUN pip install django
#docker build --t ubuntu20-ssh .
EXPOSE 22
EXPOSE 443
EXPOSE 8000

ENTRYPOINT ["entry_point.sh"]
CMD    ["/usr/sbin/sshd", "-D", "-e"]