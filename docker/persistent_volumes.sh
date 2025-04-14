#!/bin/bash

build(){
    file=${1:-"docker-compose.portainer.yaml"}
    cp docker-compose.yaml $file
    sed -i 's/.\/volumes/${VOLUMES_HOST:-.\/volumes}/' $file
    echo "build $file"
}

sync() {
    dir=${1:-"/root/home/dify/volumes"}
    cd ./volumes
    for file in $(git ls-files); do 
        mkdir -p $dir/$(dirname $file)
        cp $file  $dir/$file
        echo "sync $dir/$file"
    done
}

case "$1" in
    build)
        build $2
        ;;
    sync)
        sync $2
        ;;
    *)
        echo "Usage: $0 {build|sync}"
        exit 1
        ;;
esac