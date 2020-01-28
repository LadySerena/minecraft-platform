#!/bin/bash
sudo apt-get update
sudo apt-get install software-properties-common -y
sudo apt-add-repository --yes --update ppa:ansible/ansible
sudo apt-get install gpg unzip ansible -y
gpg --import /tmp/aws2-key
curl -o /tmp/awscliv2.sig https://d1vvhvl2y92vvt.cloudfront.net/awscli-exe-linux-x86_64.zip.sig
curl "https://d1vvhvl2y92vvt.cloudfront.net/awscli-exe-linux-x86_64.zip" -o "/tmp/awscliv2.zip"
gpg --verify /tmp/awscliv2.sig /tmp/awscliv2.zip
unzip /tmp/awscliv2.zip -d /tmp/
sudo /tmp/aws/install
aws2 --version
ansible --version