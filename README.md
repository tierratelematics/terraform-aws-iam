# terraform-aws-iam

This repository is a set of Terraform modules for defining IAM resources.

## Quickstart

The easiest way to get the modules and running is by creating a Terraform definition for it, copy this snippet in a file
named `main.tf`:

```hcl
module "asg-server-role" {
  source = "git::https://github.com/tierratelematics/terraform-aws-iam.git//modules/iam/role?ref=0.1.0"

  project     = "${var.project}"
  environment = "${var.environment}"
  subject     = "backend-asg"

  principals = [
    "ec2.amazonaws.com",
  ]

  actions = [
    "logs:CreateLogGroup",
    "logs:CreateLogStream",
    "logs:PutLogEvents",
    "logs:Describe*",
    "logs:PutRetentionPolicy",
    "ec2:Describe*",
  ]
}
```


## License

Copyright 2017 Tierra SpA

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

[http://www.apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0)

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
