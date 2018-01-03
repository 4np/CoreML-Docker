#!/usr/bin/env bash

# make sure we have docker installed
if [ $(docker -v|echo $?) -eq 0 ]; then
    # build docker image
    docker build -t convert-coreml .

    # run docker container
    docker run --rm -it -p 8888:8888 -v $(pwd)/notebook:/workspace/notebook convert-coreml
else
    echo "You don't seem to have Docker installed :'("
    echo ""
    echo "Install Docker for your platform here: https://www.docker.com/community-edition"
fi

