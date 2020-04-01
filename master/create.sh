#!/bin/bash

sudo chown -R 999:999 /home/vektor32/vektor-postgres/postgresql

NETID=`docker network ls --filter="name=isolated" --format="{{.ID}}"`
if [ -z "$NETID" ]; then
    docker network create --driver bridge isolated
fi

docker run -dit --restart unless-stopped \
        --name vektor-postgres \
        --hostname vektor-postgres \
        --network isolated \
        -p 10.129.19.211:5432:5432 \
        -p 127.0.0.1:5432:5432 \
        -v /home/vektor32/vektor-postgres/postgresql/9.6/main:/var/lib/postgresql/data \
        -e POSTGRES_PASSWORD=ySUH2aMY \
        -e POSTGRES_USER=postgres \
        -e POSTGRES_DB=symway \
        -e PG_REP_USER=replication \
        -e PG_REP_PASSWORD=dy7aW5Xw \
        vektor-postgres-master