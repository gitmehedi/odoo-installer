#!/bin/bash

image=odoo:10.0
name=odooV10

if [ "$1" == "run" ]; then

    docker run \
        -v ./config:/etc/odoo \
        -v odoo-data:/var/lib/odoo \
        -v ./addons:/mnt/extra-addons \
        -p 8069:8069 \
        --name $name \
        --link db:db \
        -it $image
fi

if [ "$1" == "deploy" ]; then
    docker image build -t  $image .
fi

