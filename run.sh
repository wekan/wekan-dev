#!/bin/bash

sudo WEKAN_UID="$(id -u)" WEKAN_GID="$(id -g)" docker-compose up -d
