#!/bin/bash

# filename: entrypoint.sh

# MONGODB_NODES examples
# MONGODB_NODES=172.10.17.101,172.10.17.102,172.10.17.103,172.10.17.104
# export MONGODB_NODES=172.10.17.101,172.10.17.102,172.10.17.103,172.10.17.104

newline="mongod.product.uri=mongodb:\/\/"

string=$MONGODB_NODES
# split to IP array
array=(${string//,/ })
for i in "${!array[@]}"
do
    echo "${array[i]}"
    item="${array[i]}:27017,"
    echo "$item"
    newline=$newline$item
    echo $newline
done

# replace last ,
newline=${newline::-1}

echo "Final newline"
echo $newline

# replace line
# oldline
# mongod.product.uri=...
# newline
# $newline

sed -i "s/mongod\.product\.uri=.*/${newline}/" /linker/cluster_mgmt.properties

tail /linker/cluster_mgmt.properties

# start
# DO NOT USE nohup
/linker/cluster_mgmt -config=/linker/cluster_mgmt.properties

