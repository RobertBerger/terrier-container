#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
DIR="$(basename $DIR)"
CONTAINER_NAME="$DIR"
IMAGE_NAME="terrier-container-x86-64"
#TAG="latest"
TAG="2020-07-24"
