# saltstack-docker
Saltstack running in [CentOS 7](https://www.centos.org) [Docker](https://www.docker.com) container.

### Prerequisites

This requires [Docker 1.10.0](https://github.com/docker/docker/releases) with [Compose 1.6](https://github.com/docker/compose/releases). Check your versions:

    docker --version
    docker-compose --version

Please note, you can download the [latest Docker Toolbox](https://github.com/docker/toolbox/releases) to get the latest versions.


## Quickstart

Download:

    git clone https://github.com/fredrikaverpil/saltstack-docker.git
    cd saltstack-docker


Verify IP address of your Docker host and edit `assets/minion/etc/salt/minion` accordingly:

    docker-machine ip default

Pull the Docker image (see [Dockerhub repository](https://hub.docker.com/r/fredrikaverpil/saltstack/tags/) for available images):

    docker pull fredrikaverpil/saltstack:2016.11.2

...or build the image from scratch:

    docker-compose build

Run the containers (will build the Docker image if you did not pull or build in previous steps):

    docker-compose up

Enter the salt-master:

    docker exec -it salt /bin/bash

Accept key from minion (you may have to wait a minute before the minion shows up):

    salt-key
    salt-key --accept-all


## Ping

Test if all minions can be pinged:

    salt '*' test.ping


## States

States are defined in `assets/master/srv/salt` which maps to `/srv/salt` on the salt master. Right now, there's a simple setup in place where the `top.sls` file dictates the following:

- all minions should be equipped with `git` (see `core.sls`)
- all minions _running Windows_ should be equipped with `FileZilla` (see `repos/windows.sls`)
- all minions _running RedHat (or CentOS)_ should be equipped with `net-tools` (see `repos/centos.sls`)


### Windows specifics

Set up the winrepo on the salt master:

    salt-run winrepo.update_git_repos # update winrepo on salt master
    salt-run winrepo.genrepo # compile repository cache
    salt -G 'os:windows' pkg.refresh_db # sync repo to Windows minions

Check installed packages:

    salt -G 'os:windows' pkg.list_pkgs # show installed packages on minions running Windows

Please read more here: https://docs.saltstack.com/en/latest/topics/windows/windows-package-manager.html

You can debug the minion running Windows by checking the logfile at `C:\salt\var\log\salt\minion`.


### Apply states

Apply the highstate:

    salt '*' state.highstate test=true # first just test it
    salt "*" state.highstate # then apply it

Apply a single state:

    salt -G 'os:windows' state.apply repos.windows
