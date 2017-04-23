#!/bin/bash

echo "listen_addresses = '*'" >> /opt/pg10/data/postgresql.conf 
echo "wal_level = 'logical'" >> /opt/pg10/data/postgresql.conf
echo "track_commit_timestamp = on" >> /opt/pg10/data/postgresql.conf

echo "host all  all    0.0.0.0/0  trust" >> /opt/pg10/data/pg_hba.conf