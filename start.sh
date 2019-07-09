#!/usr/bin/env bash

docker stop irma_container
docker run -it --rm --env BASE_URL="https://acc.fixxx10.amsterdam.nl" -p8088:8088 --name irma_container irma
