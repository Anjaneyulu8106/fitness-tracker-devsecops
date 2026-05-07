#!/bin/bash

echo "Detecting stack..."

if [ -f "package.json" ]; then
  echo "NODE=true" >> $GITHUB_ENV
fi

if [ -f "Dockerfile" ]; then
  echo "DOCKER=true" >> $GITHUB_ENV
fi

if ls *.yaml 1> /dev/null 2>&1; then
  echo "K8S=true" >> $GITHUB_ENV
fi