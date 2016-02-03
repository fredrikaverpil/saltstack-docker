# saltstack-docker
Saltstack running in [CentOS 7](https://www.centos.org) [Docker](https://www.docker.com) container.

### Prerequisites

This requires [Docker 1.10](https://github.com/docker/docker/releases) with [Compose 1.6](https://github.com/docker/compose/releases). Check your versions:

    docker --version
    docker-compose --version

Please note, you can download the [latest Docker Toolbox](https://github.com/docker/toolbox/releases) to get the latest versions.


### Quickstart

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

Accept key from minion (you may have to wait a minute before the minion shows up):

    salt-key
    salt-key --accept-all

Get minion details (so called grains):

    salt salt-minion grains.items

Check out the good "getting started with salt in 5 minutes" guide over at [amon.cx](https://www.amon.cx/blog/saltstack-review/).