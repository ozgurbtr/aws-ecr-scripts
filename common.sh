#!/usr/bin/env bash 
# Acquire login for docker daemon using AWS CLI
# Login token is temporary should be called before each remote docker operation

# args: region, repo, profile
attempt_login() 
{   
	ECR_REGION=$1
	ECR_REPO=$2
	PROFILE=$3

	echo "Acquiring docker login as manager for repository: $ECR_REPO"  
	DOCKER_LOGIN=$(aws ecr get-login --region us-west-2 --profile docker-manager)

	echo "Using acquired credentials to log on: $ECR_REPO" 
	LOGON_SUCCES=$($DOCKER_LOGIN > /dev/null;echo $?)
	if (( LOGON_SUCCES == 0 )); then
		echo "Logged on"
		return 0;
	else
		echo "Unable to login"
		return 1;
	fi
}

# args: region, repo, profile
docker_login(){
	ECR_REGION=$1
	ECR_REPO=$2
	PROFILE=$3

	COUNT=0
	until attempt_login $ECR_REGION $ECR_REPO $PROFILE
	do
		((COUNT++)) && ((COUNT==10)) && break
	done
}
