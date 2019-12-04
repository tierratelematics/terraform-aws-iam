locals {

  prefix = format("%s-%s-%s", var.project, var.environment, var.subject)
}

/*
 * Resources
 */

resource "aws_iam_role" "role" {
  name               = format("%s-role", local.prefix)
  assume_role_policy = data.aws_iam_policy_document.assume-role-policy-document.json
  path               = var.path
}

data "aws_iam_policy_document" "assume-role-policy-document" {
  
  statement {
    effect = "Allow"

    principals {
      identifiers = var.principals
      type = "Service"
    }

    actions = [
      "sts:AssumeRole"
    ]
  }
}

//
// Attach Existing Policies
//

data "aws_iam_policy" "managed-policy" {
  count = length(var.policies)
  arn   = element(var.policies, count.index)
}

resource "aws_iam_role_policy_attachment" "existing-role-policy-attachment" {
  count = length(var.policies)

  policy_arn = element(data.aws_iam_policy.managed-policy.*.arn, count.index)
  role       = aws_iam_role.role.name
}

//
// Create New Custom Policy
//

resource "aws_iam_policy" "policy" {
  count = length(var.actions) > 0 ? 1 : 0

  name        = format("%s-policy", local.prefix)
  path        = "/"
  description = format("%s-policy", local.prefix)
  policy      = data.aws_iam_policy_document.policy-document[0].json
}

data "aws_iam_policy_document" "policy-document" {
  count = length(var.actions) > 0 ? 1 : 0

  statement {

    effect = var.effect
    resources = var.resources
    actions = var.actions

  }
}

resource "aws_iam_role_policy_attachment" "role-policy-attachment" {
  count = length(var.actions) > 0 ? 1 : 0

  policy_arn = aws_iam_policy.policy[0].arn
  role       = aws_iam_role.role.name
}
