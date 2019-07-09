#!/usr/bin/env bash

docker stop irma_container
docker run -it --rm --env CONFIGFILE="./config/irmaserver-acc.json" -p8088:8088 --name irma_container irma
