#!/usr/bin/env bash 
# docker-manager aws profile with access to ecr repository
# ~/.aws/credentials
# ~/.aws/config
# Config script


ECR_REGION=us-west-2 # region of ecr repo on aws
ECR_REPO=my-ecr-repo # ecr repo name
PROFILE=docker-manager # aws profile with credentials
DOCKER_FILE_DIRECTORY_PATH=~/hello-world/ # path to docker directory having Dockerfile
REPOSITORY_URI="account_number.dkr.ecr.us-west-2.amazonaws.com/repo_name" # full docker repo URI with account number
