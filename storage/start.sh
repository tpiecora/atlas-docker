#!/bin/sh
#echo "127.0.0.1 dynamodb.us-east-1.amazonaws.com" >> /etc/hosts

# # Start dynamo
java -Djava.library.path=/usr/dynamodb-local/DynamoDBLocal_lib -jar /usr/dynamodb-local/DynamoDBLocal.jar &

wait