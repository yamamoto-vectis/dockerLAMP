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
docker ps -a
```
The result should be:
```
CONTAINER ID        IMAGE                          COMMAND                   CREATED             STATUS                      PORTS                                      NAMES
8bd9ecc41c4e        mysql:5.7                      "docker-entrypoint.s…"    9 minutes ago       Up 9 minutes                0.0.0.0:3306->3306/tcp                     dockerlamp_dbserver_1
565626ab8a88        dockerlamp_dockerlamp          "/bin/sh -c '/usr/bi…"    9 minutes ago       Up 8 minutes                0.0.0.0:80->80/tcp, 0.0.0.0:443->443/tcp   dockerlamp_dockerlamp_1
fe9d7dae957a        dockerlamp_toolbox             "/sbin/init"              9 minutes ago       Up 9 minutes                                                           dockerlamp_toolbox_1
28c91107d6a7        dockerlamp_githook_installer   "/bin/sh -c 'sh -c \"…"   9 minutes ago       Exited (0) 9 minutes ago                                               dockerlamp_githook_installer_1
9abde92e90c5        cloudflare/phan                "sh -c 'cd /mnt/src …"    9 minutes ago       Exited (0) 8 minutes ago                                               dockerlamp_phan_1


```
### Login to container
```
docker exec -ti dockerlamp_dockerlamp_1 bash
```
### Working with MySQL
By default, the root user is lftv and the db service is dbserver. Run the following command to connect to DB 
```
docker exec -ti dockerlamp_dbserver_1 mysql -u lftv -p
```
Run the following command to connect DB from dockerlamp_dockerlamp_1
```
mysql -h dbserver -u lftv -p
```
