#!/bin/bash
if [ ! -s "$MOUNT_PG_DATA/PG_VERSION" ]; then
until ping -c 1 -W 1 ${PG_MASTER_HOST:?missing environment variable. PG_MASTER_HOST must be set}
    do
        echo "Waiting for master to ping..."
        sleep 1s
done
until pg_basebackup -h ${PG_MASTER_HOST} -D ${MOUNT_PG_DATA} -U ${PG_REP_USER} -vP -W
    do
        echo "Waiting for master to connect..."
        sleep 1s
done
fi