#!/bin/bash

# Point AWS services to self
#echo "$CONTAINER_IP kinesis.us-east-1.amazonaws.com" >> /etc/hosts
#echo "127.0.0.1 dynamodb.us-east-1.amazonaws.com" >> /etc/hosts
#echo "$CONTAINER_IP master" >> /etc/hosts

# # Start nginx

# doing this because it's an easy way to keep this container running
nginx -g 'daemon off;' & 
wait