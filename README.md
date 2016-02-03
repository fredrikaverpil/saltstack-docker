# saltstack-docker
Saltstack running in CentOS 7 Docker container

### Quickstart

Prerequisites:

This requires Docker 1.10 with Compose 1.6. Check your versions:

    docker --version
    docker-compose --version

Download:

    git clone https://github.com/fredrikaverpil/saltstack-docker.git
    cd saltstack-docker


Verify IP address of your Docker host and edit `assets/minion/etc/salt/minion` accordingly:

    docker-machine ip default


Run the containers:

    docker-compose build
    docker-compose up

Enter the salt-master:

    docker exec -it salt_master /bin/bash

Accept key from minion:

    salt-key
    salt-key --accept-all

Get minion details (so called grains):

    salt salt-minion grains.items

Check out the good "getting started with salt in 5 minutes" guide over at [amon.cx](https://www.amon.cx/blog/saltstack-review/).