#!/bin/bash
gsutil ls gs://deb-package-bucket/
gsutil cp gs://deb-package-bucket/prometheus.deb /tmp
ls -alh /tmp
sudo apt-get install -y /tmp/prometheus.deb
rm /tmp/prometheus.deb
