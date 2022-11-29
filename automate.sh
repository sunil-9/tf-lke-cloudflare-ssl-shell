#!/bin/bash

function create_cluster() {
    echo "Creating cluster with $* arguments as follows:"
    //for loop to print all the argumanets
    for i in "$@"; do
        echo "$i"
    done
}

if [ $1 == "install" ]; then
    echo "installing"
    create_cluster hello hello1 hello2 3k3 4k 5k
    exit 0
elif [ $1 == "destory" ]; then
    echo "destorying"
    exit 0
elif [ $1 == "--help" ]; then
    echo "Usage: ./automate.sh [option]"
    echo "Options:"
    echo "  install: install the infrastructure"
    echo "  destory: destory the infrastructure"
    exit 0
elif [ $1 == "-h" ] 
then
    echo "Usage: ./automate.sh [option]"
    echo "Options:"
    echo "  install: install the infrastructure"
    echo "  destory: destory the infrastructure"
    exit 1
else
    echo "[*]Please enter a valid argument"
    echo "Usage: ./automate.sh [install|destory|--help|-h]"
    exit 1
fi

