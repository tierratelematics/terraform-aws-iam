/*
 * Required
 */

variable "project" {
  description = "Project name"
}

variable "environment" {
  description = "Environment (such as dev, ci, prod)"
}

variable "subject" {
  description = "Subject that requires the role"
}

variable "principals" {
  type        = "list"
  description = "List of Principals to build the trust relationship with."
}

/*
 * Optional
 */

variable "path" {
  default = "/"
}

variable "effect" {
  description = "Either 'Allow' or 'Deny', to specify whether this statement allows or denies the given actions."
  default     = "Allow"
}

variable "resources" {
  type        = "list"
  description = "List of affected resources."
  default     = ["*"]
}

variable "actions" {
  type        = "list"
  description = "List of allowed actions."
  default     = []
}

variable "policies" {
  type        = "list"
  description = "ARNs of all managed policies ti attach ti this role."
  default     = []
}
