#!/usr/bin/env bash
docker rm sod_db
MYSQL_ROOT_PASSWORD=Welcome1
docker run --name sod_db -p 3307:3306 -v /Users/cesaregb/dev/deleteme/db:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD} -d mysql:8.0.2
# cat db-dump.sql | docker exec -i sod_db /usr/bin/mysql -u root --password=${MYSQL_ROOT_PASSWORD}
# docker exec sod_db /usr/bin/mysqldump -u root --password=Welcome1 sod_db --routines --triggers --databases > backup.sql

# Backup
# docker exec CONTAINER /usr/bin/mysqldump -u root --password=root DATABASE > backup.sql
# Restore
# cat backup.sql | docker exec -i CONTAINER /usr/bin/mysql -u root --password=root DATABASE


# https://stackoverflow.com/questions/35845144/how-can-i-create-a-mysql-db-with-docker-compose
