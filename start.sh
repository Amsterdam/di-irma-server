#!/usr/bin/env bash

docker stop irma_container
docker build -t irma .
# docker run -it --rm --env BASE_URL="https://attr.auth.amsterdam.nl" -p8088:8088 --name irma_container irma
docker run -it --rm --env BASE_URL="https://acc.attr.auth.amsterdam.nl" -p8088:8088 --name irma_container irma
