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
8bd9ecc41c4e        mysql:5.7                      "docker-entrypoint.s…"    48 seconds ago      Up 38 seconds               0.0.0.0:3306->3306/tcp                     dockerlamp_dbserver_1
565626ab8a88        dockerlamp_dockerlamp          "/bin/sh -c '/usr/bi…"    48 seconds ago      Up 7 seconds                0.0.0.0:80->80/tcp, 0.0.0.0:443->443/tcp   dockerlamp_dockerlamp_1
fe9d7dae957a        dockerlamp_toolbox             "/sbin/init"              48 seconds ago      Up 38 seconds                                                          dockerlamp_toolbox_1
28c91107d6a7        dockerlamp_githook_installer   "/bin/sh -c 'sh -c \"…"   48 seconds ago      Exited (0) 9 seconds ago                                               dockerlamp_githook_installer_1
9abde92e90c5        cloudflare/phan                "sh -c 'cd /mnt/src …"    48 seconds ago      Exited (0) 8 seconds ago                                               dockerlamp_phan_1

```
### Login to container
```
docker exec -ti dockerlamp_dockerlamp_1 bash
```
### Working with MySQL
By default, the root user is lftv and the db service is dbserver. Run the following comand to connect to DB
```
mysql -h dbserver -u lftv -p
```
