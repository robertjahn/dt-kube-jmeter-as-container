#!/bin/bash
showUsage()
{
  echo "Usage: create_docker.sh [Image Version] [Image name]"
}

VERSION=$1
if [ -z "$1" ]; then
    echo -e "Version is required argument\n"
    showUsage
    exit 1
fi

if [ -z "$2" ]; then
    IMAGE="robjahn/jmeter"
fi

docker build -t ${IMAGE}:${VERSION} .
docker tag ${IMAGE}:${VERSION} ${IMAGE}:latest

