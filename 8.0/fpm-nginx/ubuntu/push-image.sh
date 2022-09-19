#!/bin/bash

BASEIMAGE="desmart/php"
TAG="8.0-fpm-nginx-ubuntu"
IMAGE="${BASEIMAGE}:${TAG}"

docker buildx build --no-cache --pull --platform="linux/amd64,linux/arm64" --tag ${IMAGE} --push .
