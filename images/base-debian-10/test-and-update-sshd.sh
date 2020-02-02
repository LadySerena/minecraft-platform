#!/bin/bash
sudo mv /tmp/sshd_config /etc/ssh/sshd_config
sudo sshd -t
sudo systemctl reload sshd