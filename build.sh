#!/bin/bash

# Default version to "latest" if not provided
VERSION=${1:-latest}

# Set branch name based on the version
if [ "$VERSION" == "latest" ]; then
    BRANCH="develop"
else
    BRANCH="$VERSION"
fi

echo "Using version: $VERSION"
echo "Using branch: $BRANCH"

docker buildx build --platform linux/amd64,linux/arm64 --build-arg BRANCH="$BRANCH" --push -t ghcr.io/damintsew/simple-elastix-base:"$VERSION" ./Docker
docker push -t docker.io/damintsew/simple-elastix-base:$VERSION
