#!/usr/bin/env bash 
# This script deletes emtpy tags on repo since creating latest tags makes
# previous latest empty and stale

source common.sh
source config.sh

delete_empty_tags()
{
	echo "Querying empty tags"
	
	IMAGES_TO_DELETE=$(aws ecr list-images --region $ECR_REGION --profile $PROFILE --repository-name $ECR_REPO --filter "tagStatus=UNTAGGED" --query 'imageIds[*]' --output json)
	echo "deleting empty tagged repos: $IMAGES_TO_DELETE"  
	aws ecr batch-delete-image --region $ECR_REGION --profile $PROFILE --repository-name $ECR_REPO --image-ids "$IMAGES_TO_DELETE" > /dev/null || true
}

docker_login $ECR_REGION $ECR_REPO $PROFILE
delete_empty_tags
