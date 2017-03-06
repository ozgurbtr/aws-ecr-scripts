#!/usr/bin/env bash 
# This scripts builds a docker image and pushes it to ecr
# Createst a latest version tag and a latest tag for the pushed image
# Increments minor version field automatically
# Create a version.txt file in Dockerfile directory with Major.Minor.Build 
# number structure

source common.sh
source config.sh

FULL_VERSION=0.0.1
MAJOR=0
MINOR=0
BUILD=1

get_version()
{	
	pushd $DOCKER_FILE_DIRECTORY_PATH
	FULL_VERSION=$(cat version.txt)
	IFS=. read MAJOR MINOR BUILD <<<"${FULL_VERSION}"
	popd
}

build_and_tag(){
	pushd $DOCKER_FILE_DIRECTORY_PATH
	((BUILD++))
	FULL_VERSION=$MAJOR.$MINOR.$BUILD
	echo $FULL_VERSION > version.txt
	docker build -t "$REPOSITORY_URI:$FULL_VERSION" .
	docker tag -f "$REPOSITORY_URI:$FULL_VERSION" "$REPOSITORY_URI:latest"
	docker push "$REPOSITORY_URI:$FULL_VERSION"
	docker push "$REPOSITORY_URI:latest"
	popd
}

docker_login $ECR_REGION $ECR_REPO $PROFILE
get_version
build_and_tag

