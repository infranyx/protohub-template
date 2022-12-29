#!/bin/bash

echo "--------------------  PROTO BUILDING OF ${TARGET_GO_REPOSITORY} --------------------";

if [ $CI_MERGE_REQUEST_TARGET_BRANCH_NAME == "main" ]
then
    echo "main branch detected ==> deploy minor-release ci for target repo."
    cp ./ci/major-release/.gitlab-ci.yml gen/go
elif [ $CI_MERGE_REQUEST_TARGET_BRANCH_NAME == "dev" ]
then
    echo "dev branch detected ==> deploy patch-release ci for target repo."
    cp ./ci/minor-release/.gitlab-ci.yml gen/go
fi
 
echo "-------------------- CREATE GO MODULE ${TARGET_GO_REPOSITORY}  --------------------";
cd gen/go
go mod init gitlab.hamrah.in/${TARGET_GO_REPO}
go mod tidy

 
echo "-------------------- PUSH TO ${TARGET_GO_REPOSITORY}  --------------------";
git remote remove origin
# git config user.email "my-email@email.com"
# git config user.name "ci-bot"
git remote add origin https://oauth2:${ACCESS_TOKEN}@gitlab.hamrah.in/${TARGET_GO_REPO}.git
git add .
git commit -m ""
git push --set-upstream origin $BRANCH;

cd ../..
echo "-------------------- END --------------------";