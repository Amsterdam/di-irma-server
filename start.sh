#!/usr/bin/env bash

docker stop irma_container
docker rm irma_container
docker run -it -p8088:8088 --name irma_container irma
