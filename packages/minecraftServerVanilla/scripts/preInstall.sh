#!/bin/bash
getent group minecraft >/dev/null || groupadd -r minecraft
getent passwd minecraft >/dev/null || \
    useradd -r -g minecraft -d /minecraft -s /sbin/nologin \
    -c "service account for minecraft server" minecraft