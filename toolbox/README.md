# Static Code Analysis Toolbox
Alpine Linux with following tools:
- phpcs 3.x
- phpmd
- eslint (Airbnb)

Because you forget.
### Build image
```
docker build -t toolbox .
```
### Run container
```
docker run -v "/Users/kura/work/project:/mnt/src" -itd --name toolbox toolbox
```
## Usage
```
docker exec -t toolbox phpcs --standard=PSR2 /mnt/src/xxx.php
docker exec -t toolbox phpmd /mnt/src/xxx.php text unusedcode,codesize,naming
docker exec -t toolbox /var/tmp/node_modules/.bin/eslint /mnt/src/xxx.js
```

