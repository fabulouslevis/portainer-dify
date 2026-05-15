#!/bin/bash

build(){
    file=${1:-"docker-compose.portainer.yaml"}
    cp docker-compose.yaml $file
    sed -i 's/.\/volumes/${VOLUMES_HOST:-.\/volumes}/' $file
    sed -i 's/.\/envs/${ENVS_HOST:-.\/envs}/' $file
    sed -i 's/.\/.env/${DOT_ENV:-.\/.env}/' $file
    echo "build $file"
}

sync() {
    dir=${1:-"/root/home/dify"}
    cd ./volumes
    for file in $(git ls-files); do 
        mkdir -p $dir/volumes/$(dirname $file)
        cp $file  $dir/volumes/$file
        echo "sync $dir/volumes/$file"
    done
    cd ../envs
    for file in $(git ls-files); do 
        mkdir -p $dir/envs/$(dirname $file)
        cp $file  $dir/envs/$file
        echo "sync $dir/envs/$file"
    done
    cd ..
    cp .env.example $dir/
    echo "sync $dir/.env.example"
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