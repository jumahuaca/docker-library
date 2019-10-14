#!/usr/bin/env bash

docker-entrypoint.sh postgres &
cd jumahuaca-core-master
mvn clean install
cd ..
cd jumahuaca-spring-example-master
mvn clean install
cd target
java -jar springuvaapi-0.0.1-SNAPSHOT.jar
/bin/bash

