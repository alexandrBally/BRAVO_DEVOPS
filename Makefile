
BACKUP_DIR=/home/alexelef/Desktop/Project-practic/db_backup/
BACKUP_FILE_POSTGRES=${POSTGRES_DB}-${DATE}.sql
BACKUP_FILE_POSTGRES=${POSTGRES_DB}-${DATE}.sql
DATE=$(shell date +%Y-%m-%d_%H:%M:%S)
BACKUP_FILE_REDIS=Redis-${DATE}.sql

include .env
export $(shell sed 's/=.*//' .env)

#Docker
start:
	docker compose up --build 
stop: 
	docker compose down

restart:
	docker compose down 
	echo "Y" | docker container prune 
	echo "Y" | docker system prune -f 
	docker compose up --build 
migrate:
	docker exec -i backend npm run db:migrate:up

cleaning:
	echo "Y" | docker container prune
	echo "Y" | docker system prune -f 

#Install Dockerfile
dockerfile-backend:
	cat ./Dockerfile/Dockerfile_be > ./backend/Dockerfile
dockerfile-backend:
	cat ./Dockerfile/Dockerfile_fe > ./frontend/Dockerfile
dockerfile-install:
	cat ./Dockerfile/Dockerfile_fe > ./frontend/Dockerfile
	cat ./Dockerfile/Dockerfile_be > ./backend/Dockerfile

#Data base backup
postgres:
	mkdir ./db_backup || echo "cannot create directory db_backup: File exists"
	docker exec postgres pg_dump -U ${POSTGRES_DB_USER} ${POSTGRES_DB} > ${BACKUP_DIR}${BACKUP_FILE_POSTGRES}
redis:
	mkdir ./db_backup || echo "cannot create directory db_backup: File exists"
	docker exec redis redis-cli SAVE
	docker cp redis:/data/dump.rdb ${BACKUP_DIR}${BACKUP_FILE_REDIS}
backup-all:
	mkdir ./db_backup || echo "cannot create directory db_backup: File exists"
	docker exec postgres pg_dump -U ${POSTGRES_DB_USER} ${POSTGRES_DB} > ${BACKUP_DIR}${BACKUP_FILE_POSTGRES}
	docker exec redis redis-cli SAVE
	docker cp redis:/data/dump.rdb ${BACKUP_DIR}${BACKUP_FILE_REDIS}

copy:
	if [ ! -f ./test ]; then cp ./Dockerfile/test .test; fi



