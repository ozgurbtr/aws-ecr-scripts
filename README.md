This scripts allow you build and automatically tag  and push your docker images on AWS ECR repository easily  
It creates a latest tag and a version tag for latest builded image. 

Requirements:
- Requires AWS CLI
- AWS CLI profile named docker-manager for an IAM user with credentials for full access to ECR repo
- Update config.sh
- Run build-tag-latest.sh to build and push your new image
- Run delete-untagged.sh to remove old empty tags
