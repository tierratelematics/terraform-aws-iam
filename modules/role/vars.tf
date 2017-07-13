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

variable "actions" {
  type        = "list"
  description = "List of allowed actions."
}


/*
 * Optional
 */

variable "resources" {
  type        = "list"
  description = "List of affected resources."
  default     = ["*"]
}
