#!/bin/bash
systemctl enable nodeExporter.service
mkdir -p /nodeExporter
chown nodeExporter:nodeExporter /nodeExporter
chmod 0751 /nodeExporter