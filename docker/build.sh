#!/bin/bash

: ${tag=latest}

cd docker
docker buildx build --platform linux/amd64,linux/arm64/v8 \
    --tag ghcr.io/wangsyi/ninja:$tag \
    --tag ghcr.io/wangsyi/ninja:latest \
    --tag wangsyi/ninja:$tag \
    --tag wangsyi/ninja:latest \
    --build-arg VERSION=$tag --push .
cd -
