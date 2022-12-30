# ProtoHub Template

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

**Table of Contents**

- [ProtoHub Template](#protohub-template)
  - [Features](#features)
  - [Prerequisites](#prerequisites)
  - [Getting Started](#getting-started)
  - [Versioning](#versioning)
  - [CI/CD](#cicd)
  - [Github Action](#github-action)
  - [Customization](#customization)
  - [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

ProtoHub template is a ProtoHub for storing and building Protocol Buffers (protos) in a pipeline. It allows other projects to easily import the generated code, reducing the need to maintain duplicate copies of the same protos in multiple repositories. ProtoHub supports both GitLab and GitHub for hosting and running the pipeline.

## Features

- Store protos in a central location
- Build protos automatically as part of the pipeline
- Generate code in multiple languages (currently only supporting Go)
- Use the [Buf CLI](https://docs.buf.build/) to lint, validate, and build your protos (optional)

## Prerequisites

- GitLab or GitHub instance with a pipeline set up
- Repository to store the generated code
- [Buf CLI](https://docs.buf.build/) (optional, only needed if you want to use it for linting and validation)

## Getting Started

1. Set up a pipeline in your GitLab or GitHub instance and specify the repository where the generated code should be pushed.
2. Clone the ProtoHub repository:

```bash
git clone https://github.com/infranyx/protohub-template.git
```

3. Navigate to the directory:

```bash
cd proto-hub
```

4. Add your protos to your sepcifc directory (each Namespace can have directory).
5. If you want to use the Buf CLI for linting and validation, create a `buf.yaml` file in the root directory of the repository. This file specifies the configuration for the Buf CLI. For more information on the available configuration options, see the [Buf CLI documentation](https://docs.buf.build/).
6. If you want to customize the code generation process, create a `buf.gen.yaml` file in the root directory of the repository. This file specifies the configuration for the code generation process. For more information on the available configuration options, see the [Buf CLI documentation](https://docs.buf.build/).
7. Push your changes to the repository to trigger the pipeline.
   The pipeline will handle the code generation process and push the generated code to the specified repository as a separate module (project).
8. Use the `go get` command to retrieve the generated code in your project:

```bash
go get github.com/<your_username>/<generated_code_repository>
```

9. Import the generated code in your project:

```go
import (
  "github.com/<your_username>/<generated_code_repository>"
)
```

## Versioning

ProtoHub uses [semantic versioning](https://semver.org) to version the generated code. When a new release is created, the pipeline uses the git tag and git push commands to create and push a new tag to the repository. The tag will be in the format vX.Y.Z, where X is the major version, Y is the minor version, and Z is the patch version.

- When merging to the dev branch, a patch release will be createdand the patch version will be incremented.
- When merging to the `main` branch, a minor release will be created and the minor version will be incremented.

For example, if the current version is `v1.2.3`, merging to the `dev` branch will create a new release with the version `v1.2.4`. Merging to the `main` branch will create a new release with the version `v1.3.0`.

## CI/CD

ProtoHub uses GitLab CI/CD to automate the code generation process. The `.gitlab-ci.yml` file in the root directory of the repository specifies the steps of the pipeline.

- The `lint` stage runs the Buf CLI to lint the protos.
- The `build` stage generates the code and stores it in the `gen/` directory.
- The `push` stage pushes the generated code to the specified repository.

The pipeline will only run on the `dev` and `main` branches, with the exception of merge request closures.

## Github Action

ProtoHub uses Github Action to automate the code generation process. In future proccess it will be much like the gitlab-ci.

<!-- The `.github/workflows` directory in the root directory of the repository contains the pipeline configuration for GitHub. The pipeline has the following steps:

- `lint`: Runs the Buf CLI to lint the protos. This step is optional and can be commented out if the Buf CLI is not being used.
- `build`: Installs the necessary dependencies, generates the code, and stores the generated code in the gen directory.
- `push`: Pushes the generated code to the specified repository.
  The pipeline is triggered when changes are pushed to the dev or main branches. -->

## Customization

You can customize the code generation process by creating a `buf.gen.yaml` file in the root directory of the repository. This file allows you to specify the language and output directory for the generated code, as well as any additional plugins or options. For more information on the available configuration options, see the [Buf CLI documentation](https://docs.buf.build/).

## References

- [Protocol Buffers](https://developers.google.com/protocol-buffers)
- [Buf CLI](https://docs.buf.build/)
- [GitLab CI/CD](https://docs.gitlab.com/ee/ci/)
- [GitHub Action](https://docs.github.com/en/actions)
