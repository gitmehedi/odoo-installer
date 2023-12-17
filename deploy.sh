#!/bin/bash

if [ "$1" == "up" ]; then
    docker-compose up --force-recreate --build -d
fi

if [ "$1" == "down" ]; then
    docker-compose down
fi



