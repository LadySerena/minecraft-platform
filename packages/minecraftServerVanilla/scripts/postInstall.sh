#!/bin/bash
systemctl enable minecraft.service
mkdir -p /minecraft
chown minecraft:minecraft /minecraft
chmod 0751 /minecraft