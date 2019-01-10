# Apps2GROW development IDE

## Required:
- Ubuntu/Debian user interface
- Docker
  - sudo apt install docker.io
  - sudo apt install docker-compose
- Files
  - ~/.ssh/id_rsa
  - ~/.ssh/letsencrypt.key
- PostgreSQL must be uninstalled! 

## Create docker image for odoo-pycharm
```bash
git clone https://github.com/apps2grow/dev-ide 12.0
cd dev-ide
sudo docker build -t odoo-pycharm:12.0 -f ./odoo/Dockerfile .
```

## Run Docker 
(as regular user, not as root, otherwise pycharm UI will fail)
```bash
bash docker-compose.sh up
```
Odoo is running with ports 8069 & 8072.
Try in browser: localhost:8069

## PyCharm
Open project: /opt/odoo
Copy /opt/odoo/etc/odoo.conf
Add these lines:
```
http_port = 8169
longpolling_port = 8172
```
Run - Edit Configurations...
Add - Python
Name: odoo12.0
Script: /opt/odoo/sources/odoo/odoo-bin
Script parameters: -c /opt/odoo/etc/odoo_pycharm.conf
OK
Run - Debug
Try in browser: localhost:8169

## Remove Docker
sudo docker rm odoo12.0 postgres

## Troubleshooting
```bash
# Login to the docker container
docker exec -it odoo12.0 /bin/bash

# Check the database with psql
sudo apt install postgresql-client
psql -h localhost

```