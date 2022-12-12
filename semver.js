const semver = require("semver");

const v = "v0.1.0"
console.log(semver.inc(v, "patch"))
console.log(semver.valid(v))