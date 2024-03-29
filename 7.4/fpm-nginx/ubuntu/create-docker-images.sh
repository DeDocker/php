#!/bin/bash

BASEIMAGE="desmart/php"
TAG="7.4-fpm-nginx-ubuntu"
IMAGE="${BASEIMAGE}:${TAG}"

docker run --privileged --rm tonistiigi/binfmt --install all
docker buildx create --use --name multiarch
docker buildx inspect --bootstrap
docker buildx build --pull --platform="linux/amd64,linux/arm64" --tag ${IMAGE} --push .
