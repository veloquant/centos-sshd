ARG CENTOS_VERSION=7.9.2009
FROM centos:$CENTOS_VERSION

RUN yum -y install openssh-server epel-release && \
    yum -y install pwgen && \
    yum clean -y all && \
    rm -f /etc/ssh/ssh_host_ecdsa_key /etc/ssh/ssh_host_rsa_key && \
    ssh-keygen -q -N "" -t dsa -f /etc/ssh/ssh_host_ecdsa_key && \
    ssh-keygen -q -N "" -t rsa -f /etc/ssh/ssh_host_rsa_key && \
    sed -i "s/#UseDNS.*/UseDNS no/g" /etc/ssh/sshd_config && \
    sed -i "s/#UsePrivilegeSeparation.*/UsePrivilegeSeparation no/g" /etc/ssh/sshd_config

ADD set_root_pw.sh /set_root_pw.sh
ADD run.sh /run.sh
RUN chmod +x /*.sh

ENV AUTHORIZED_KEYS **None**

EXPOSE 22
CMD ["/run.sh"]

ARG CENTOS_VERSION

LABEL org.centos.version $CENTOS_VERSION
LABEL author "Yitzik Casapu"
