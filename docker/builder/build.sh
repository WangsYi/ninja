#!/bin/bash

declare -A map


map["x86_64-unknown-linux-musl"]="messense/rust-musl-cross:x86_64-musl"
map["aarch64-unknown-linux-musl"]="messense/rust-musl-cross:aarch64-musl"
map["armv7-unknown-linux-musleabi"]="messense/rust-musl-cross:armv7-musleabi"
map["armv7-unknown-linux-musleabihf"]="messense/rust-musl-cross:armv7-musleabihf"
map["arm-unknown-linux-musleabi"]="messense/rust-musl-cross:arm-musleabi"
map["arm-unknown-linux-musleabihf"]="messense/rust-musl-cross:arm-musleabihf"
map["armv5te-unknown-linux-musleabi"]="messense/rust-musl-cross:armv5te-musleabi"
# map["x86_64-pc-windows-msvc"]="ghcr.io/gngpp/cargo-xwin:latest"

for key in "${!map[@]}"; do
  docker pull "${map[$key]}"
  docker buildx build --platform linux/amd64,linux/arm64 \
    --tag ghcr.io/wangsyi/ninja-builder:"$key" \
    --build-arg BASE_IMAGE="${map[$key]}" . --push

  echo "Build complete for $key"

  docker rmi ghcr.io/wangsyi/ninja-builder:"$key"
  
  docker rmi "${map[$key]}"
done
