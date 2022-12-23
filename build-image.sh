#!/bin/bash

IMAGE="smallsoup/django-blog:v1.0.1"
docker build -t ${IMAGE} -f Dockerfile . \
&& docker push ${IMAGE}