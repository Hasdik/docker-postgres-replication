#!/bin/bash
echo "*:*:*:$PG_REP_USER:$PG_REP_PASSWORD" > ~/.pgpass

chmod 0600 ~/.pgpass

until ping -c 1 -W 1 ${PG_MASTER_HOST:?missing environment variable. PG_MASTER_HOST must be set}
    do
        echo "Waiting for master to ping..."
        sleep 1s
done

echo "host replication all all md5" >> "$PGDATA/pg_hba.conf"

set -e

cat > ${PGDATA}/recovery.conf <<EOF
standby_mode = on
primary_conninfo = 'host=$PG_MASTER_HOST port=${PG_MASTER_PORT:-5432} user=$PG_REP_USER password=$PG_REP_PASSWORD'
trigger_file = '/usr/promote_to_me_master'
EOF
chown postgres. ${PGDATA} -R
chmod 700 ${PGDATA} -R

sed -i 's/wal_level = hot_standby/wal_level = replica/g' ${PGDATA}/postgresql.conf 

exec "$@"
