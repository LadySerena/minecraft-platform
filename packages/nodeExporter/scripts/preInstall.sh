#!/bin/bash
getent group nodeExporter >/dev/null || groupadd -r nodeExporter
getent passwd nodeExporter >/dev/null || \
    useradd -r -g nodeExporter -d /nodeExporter -s /sbin/nologin \
    -c "service account for node exporter" nodeExporter