#!/usr/bin/env bash

docker pull postgres
docker run --name concourse-db \
  --net=concourse-net \
  -h concourse-postgres \
  -p 5432:5432 \
  -e POSTGRES_USER=user \
  -e POSTGRES_PASSWORD=postGresPs \
  -e POSTGRES_DB=atc \
  -d postgres


docker run  --name concourse \
  -h concourse \
  -p 8080:8080 \
  --detach \
  --privileged \
  --net=concourse-net \
  concourse/concourse quickstart \
  --add-local-user=bengt:concourse \
  --main-team-local-user=main \
  --external-url=http://127.0.0.1:8080 \
  --postgres-user=user \
  --postgres-password=postGresPs \
  --postgres-host=concourse-db \
  --worker-garden-dns-server 8.8.8.8
