#!/bin/bash
# future idea: export SOCK_SHOP_URL=$(kubectl -n sock-shop get svc front-end --template="{{range .status.loadBalancer.ingress}}{{.ip}}{{end}}")

showUsage()
{
  echo "Usage: smoke_test.sh [shopshop DNS]"
}

SOCK_SHOP_URL=$1
SOCK_SHOP_PORT=80
NUM_VUS=5
NUM_ITERATIONS=10

if [ -z "$1" ]; then
    echo -e "Sock shop DNS is required argument. Example 35.231.224.62\n"
    showUsage
    exit 1
fi


echo "Running smoke test against $SOCK_SHOP_URL..."
./launch_test.sh basiccheck.jmx $SOCK_SHOP_URL $SOCK_SHOP_PORT $NUM_VUS $NUM_ITERATIONS "SmokeTest"
