## Postgres compiled Version 10

```
➜  postgres10 git:(master) ✗ docker build --no-cache --build-arg INCUBATOR_VER=1 -t 3manuek/postgres10 .
```

root@default:/etc/default# echo "GRUB_CMDLINE_LINUX_DEFAULT=\"quiet systemd.legacy_systemd_cgroup_controller=yes\"" > /etc/default/grub



`export LC_ALL=en_US.UTF-8`

```
  163  bin/initdb -D data1 -E UTF8
  164  bin/initdb -D data2 -E UTF8
  165  bin/initdb -D data3 -E UTF8
```


#data_directory = 'ConfigDir' 
#listen_addresses = 'localhost'
#port = 5432
#wal_level = replica
#max_replication_slots = 10
#track_commit_timestamp = off
#max_worker_processes = 8

#backend_flush_after = 0                # measured in pages, 0 disables

#subscribers
#max_logical_replication_workers = 4    # taken from max_worker_processes
#max_sync_workers_per_subscription = 2  # taken from max_logical_replication_workers

#logging_collector = off
#log_replication_commands = off
#cluster_name = ''                      # added to process titles if nonempty

RUN echo "host all  all    0.0.0.0/0  md5" >> /opt/pg10/data/pg_hba.conf
