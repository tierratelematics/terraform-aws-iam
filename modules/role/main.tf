/*
 * Resources
 */

resource "aws_iam_role" "role" {
  name               = "${var.project}-${var.environment}-${var.subject}-role"
  assume_role_policy = "${data.aws_iam_policy_document.role-policy-document.json}"
}

data "aws_iam_policy_document" "role-policy-document" {
  "statement" {
    effect = "Allow"

    principals {
      identifiers = [
        "${var.principals}",
      ]

      type = "Service"
    }

    actions = [
      "sts:AssumeRole",
    ]
  }
}

resource "aws_iam_policy" "policy" {
  name        = "${var.project}-${var.environment}-${var.subject}-policy"
  path        = "/"
  description = "${var.project}-${var.environment}-${var.subject}-policy"
  policy      = "${data.aws_iam_policy_document.policy-document.json}"
}

data "aws_iam_policy_document" "policy-document" {
  "statement" {
    effect = "Allow"

    resources = [
      "${var.resources}",
    ]

    actions = [
      "${var.actions}",
    ]
  }
}

resource "aws_iam_role_policy_attachment" "role-policy-attachment" {
  policy_arn = "${aws_iam_policy.policy.arn}"
  role       = "${aws_iam_role.role.name}"
}
