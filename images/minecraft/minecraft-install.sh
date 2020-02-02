#!/bin/bash
gsutil ls gs://deb-package-bucket/
gsutil cp gs://deb-package-bucket/minecraft.deb /tmp
ls -alh /tmp
sudo apt-get update -y
sudo dpkg -i /tmp/minecraft.deb
sudo apt-get install -f -y
rm /tmp/minecraft.deb
