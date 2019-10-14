#!/usr/bin/env bash

docker-entrypoint.sh postgres &
cd jumahuaca-core-master
mvn clean install
cd ..
cd jumahuaca-dropwizard-example-master
mvn clean install
java -jar target/dropwizarduvaapi-0.0.1-SNAPSHOT.jar db migrate config.yml
java -jar target/dropwizarduvaapi-0.0.1-SNAPSHOT.jar server config.yml
/bin/bash

