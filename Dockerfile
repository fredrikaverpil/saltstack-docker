FROM centos:7

RUN rpm --import https://repo.saltstack.com/yum/redhat/7/x86_64/latest/SALTSTACK-GPG-KEY.pub

RUN touch /etc/yum.repos.d/saltstack.repo
RUN echo "[saltstack-repo]" >> /etc/yum.repos.d/saltstack.repo
RUN echo "name=SaltStack repo for RHEL/CentOS \$releasever" >> /etc/yum.repos.d/saltstack.repo
RUN echo "baseurl=https://repo.saltstack.com/yum/redhat/\$releasever/\$basearch/latest" >> /etc/yum.repos.d/saltstack.repo
RUN echo "enabled=1" >> /etc/yum.repos.d/saltstack.repo
RUN echo "gpgcheck=1" >> /etc/yum.repos.d/saltstack.repo
RUN echo "gpgkey=https://repo.saltstack.com/yum/redhat/\$releasever/\$basearch/latest/SALTSTACK-GPG-KEY.pub" >> /etc/yum.repos.d/saltstack.repo

RUN yum clean expire-cache
RUN yum update -y

# Network tools for debugging
RUN yum install -y net-tools nmap git
RUN yum install -y epel-release
RUN yum install -y python-pip
RUN pip install GitPython

# Salt and prerequisites
RUN yum install -y salt-master salt-minion salt-ssh salt-syndic salt-cloud virt-what

EXPOSE 4505
EXPOSE 4506