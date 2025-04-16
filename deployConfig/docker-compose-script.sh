
#!/bin/env bash


sudo DOCKER_IMAGE=$1 /usr/local/bin/docker-compose -f /home/ec2-user/deployConfig/docker-compose.yml up -d