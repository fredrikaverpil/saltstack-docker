FROM centos:7

RUN rpm --import https://repo.saltstack.com/yum/redhat/7/x86_64/latest/SALTSTACK-GPG-KEY.pub

RUN touch /etc/yum.repos.d/saltstack.repo && \
    echo "[saltstack-repo]" >> /etc/yum.repos.d/saltstack.repo && \
    echo "name=SaltStack repo for RHEL/CentOS \$releasever" >> /etc/yum.repos.d/saltstack.repo  && \
    echo "baseurl=https://repo.saltstack.com/yum/redhat/\$releasever/\$basearch/archive/2016.11.1" >> /etc/yum.repos.d/saltstack.repo && \
    echo "enabled=1" >> /etc/yum.repos.d/saltstack.repo && \
    echo "gpgcheck=1" >> /etc/yum.repos.d/saltstack.repo && \
    echo "gpgkey=https://repo.saltstack.com/yum/redhat/\$releasever/\$basearch/archive/2016.11.1/SALTSTACK-GPG-KEY.pub" >> /etc/yum.repos.d/saltstack.repo

RUN yum clean expire-cache && \
    yum update -y && \

    # Salt and prerequisites
    yum install -y salt-master  \
                   salt-minion  \
                   salt-ssh     \
                   salt-syndic  \
                   salt-cloud   \
                   virt-what    \
                   dmidecode && \

    # Additional tools
    yum install -y epel-release && \
    yum install -y python-pip net-tools nmap git

RUN pip install --upgrade pip && \
    pip install GitPython && \

    # Supervisor
    pip install supervisor
RUN mkdir -p /var/log/supervisor

# Ports to expose
EXPOSE 4505
EXPOSE 4506
