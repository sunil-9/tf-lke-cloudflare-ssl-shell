# Steps to create your own server in linode.

## step 0: git clone https://github.com/sunil-9/terraform-with-shell.git && cd terraform-with-shell

## step 1: docker run -it --rm -v ${HOME}:/root/ -v ${PWD}:/work -w /work --net host ubuntu sh

## step 2: apk add --no-cache curl

## step 3: apk add terraform --no-cache

## step 4: chmod +x install.sh
## step 5: ./install.sh
