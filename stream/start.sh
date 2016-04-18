#!/bin/sh

# Start kinesalite
nginx & 
node /node_modules/kinesalite/cli.js
wait