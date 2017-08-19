#!/bin/bash

PGMNAME=`basename $0`

IMAGE_SERVICES="interactivelabs/services"
IMAGE_WEB="interactivelabs/laundry-web"
IMAGE_ADMIN="interactivelabs/process-admin"
IMAGE_MONGO="mongo"

function CleanImages(){
  # clean docker
  docker volume rm $(docker volume ls -qf dangling=true)
  docker rm -v $(docker ps -aq)
  docker rmi $(docker images -q)
  echo "[Info] Docker images have been cleaned!!"
}

if [ $1 = "services" ]; then
  docker ps | grep $IMAGE_SERVICES | awk '{print $1}' | xargs docker stop
  CleanImages
  docker pull $IMAGE_SERVICES
  echo "[Info] Docker image ${IMAGE_SERVICES} downloaded"

elif [ $1 = "web" ]; then
  docker ps | grep $IMAGE_WEB | awk '{print $1}' | xargs docker stop
  CleanImages
  docker pull $IMAGE_WEB
  echo "[Info] Docker image ${IMAGE_WEB} downloaded"

elif [ $1 = "admin" ]; then
  docker ps | grep $IMAGE_ADMIN | awk '{print $1}' | xargs docker stop
  CleanImages
  docker pull $IMAGE_ADMIN
  echo "[Info] Docker image ${IMAGE_ADMIN} downloaded"

elif [ $1 = "all" ]; then
  # Stop services
  docker ps | grep $IMAGE_SERVICES | awk '{print $1}' | xargs docker stop
  docker ps | grep $IMAGE_WEB | awk '{print $1}' | xargs docker stop
  docker ps | grep $IMAGE_ADMIN | awk '{print $1}' | xargs docker stop
  docker ps | grep $IMAGE_MONGO | awk '{print $1}' | xargs docker stop
  CleanImages

  docker pull $IMAGE_SERVICES
  echo "[Info] Docker image ${IMAGE_SERVICES} downloaded"
  docker pull $IMAGE_WEB
  echo "[Info] Docker image ${IMAGE_WEB} downloaded"
  docker pull $IMAGE_ADMIN
  echo "[Info] Docker image ${IMAGE_ADMIN} downloaded"
  docker pull $IMAGE_MONGO
  echo "[Info] Docker image ${IMAGE_MONGO} downloaded"

else
	echo "[Warn] Argument not valid [services || web || admin || all]"
	exit 1;
fi

echo "[Info] Download process completed"

exit 0;
