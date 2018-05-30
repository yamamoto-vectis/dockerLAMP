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
There are 4 images will be built: a LAMP image, hookinstaller image, toolbox image and phan image. please refer README file of each image for more details
There is an environment file setup for LAMP image, please modify it as your need before build image.
Navigate to directory containing docker-compose file. If downloading from Docker Hub, move on to "Create Container" section.
```
docker-compose build
```
It will take time fot the first time. Coffe break.
### Run Containers
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
             Name                           Command               State                                 Ports
-------------------------------------------------------------------------------------------------------------------------------------------
bananabanana_dockerlamp_1          /bin/sh -c /usr/bin/env ba ...   Up       0.0.0.0:3306->3306/tcp, 0.0.0.0:443->443/tcp, 0.0.0.0:80->80/tcp
bananabanana_githook_installer_1   /bin/sh -c sh -c "cd /tmp/ ...   Exit 0
bananabanana_phan_1                sh -c cd /mnt/src && /opt/ ...   Exit 0
bananabanana_toolbox_1             /sbin/init                       Up
```
### Login to container
```
docker exec -ti bananabanana_dockerlamp_1 bash
```

