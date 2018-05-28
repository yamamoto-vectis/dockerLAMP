# Docker for LAMP/LNMP by AmazonLinux
Creates a stack images using the official Amazon Linux image for Docker. The image will have pre-commit script installed and contents of:

* Apache
* PHP
* MySQL
* PHP composer latest
* MySQL client
* Xdebug 2.6
* nginx

## Prerequisite
Install docker to your local pc via the instruction in [Docker](https://docs.docker.com/install/)
As the image is based on AmazonLinux, the local pc should be Unix-like operation system.
## Getting Started
This container is recommended for development use, to mirror or mimic development of an AWS EC2 instance running Amazon Linux.

### Build Image
There are 2 images will be built: a LAMP image and hookinstaller image, please refer README file of each image for more details
There is an environment file setup for LAMP image, please modify it as your need before build image.
Navigate to directory containing docker-compose file. If downloading from Docker Hub, move on to "Create Container" section.
```
docker-compose up -d
```
### List Container
Run the following command:
```
docker-compose ps
```
The result should be:
```
            Name                           Command               State              Ports
---------------------------------------------------------------------------------------------------
gitdocker_dockerlamp_1          /bin/sh -c /usr/bin/env ba ...   Up       3306/tcp, 443/tcp, 80/tcp
gitdocker_githook_installer_1   /bin/sh -c sh -c "cd /tmp/ ...   Exit 0
```
### Login to container
```
docker exec -ti gitdocker_dockerlamp_1 bash
```

