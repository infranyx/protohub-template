// npm i semver@7.3.8
const semver = require("semver");
try{
    const { GO_REPOSITORY, RELEASE_TAG } = process.env
    github.rest.repos.listTagProtection({
        owner : context.repo.owner,
        repo: GO_REPOSITORY,
    });
}
catch (e) {
    
}