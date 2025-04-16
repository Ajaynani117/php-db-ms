#!/usr/bin/bash
sudo yum install docker -y
sudo systemctl enable docker
sudo systemctl start docker