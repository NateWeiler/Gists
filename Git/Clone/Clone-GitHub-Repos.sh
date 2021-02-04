#!/bin/bash

YLW='\033[1;33m'
NC='\033[0m'

if [ -z $1 ]
then
    echo "Please provide github organization"
    echo ""
    echo "$ ./cloneall.sh <ORG to clone>"
    exit 1
fi

ORG=$1

HTTP_RESPONSE=`curl -s -o /dev/null -I -w "%{http_code}" https://github.com/$ORG`

if [ $HTTP_RESPONSE -ne 200 ]
then
	echo "GitHub organization doesn't exist - https://github.com/$ORG - HTTP status code $HTTP_RESPONSE"
	exit 1
fi

#declare -a repositories=("carts" "catalogue" "front-end" "k8s-deploy-production" "k8s-deploy-staging" "orders" "payment" "queue-master" "shipping" "sockshop-infrastructure" "user")

for repo in "${repositories[@]}"
do
	echo -e "${YLW}Cloning https://github.com/$ORG/$repo ${NC}"
	git clone -v --progress "https://github.com/$ORG/$repo"
	echo -e "${YLW}Done. ${NC}"
done
