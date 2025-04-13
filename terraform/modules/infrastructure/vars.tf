variable "certificates" {
  default = {}
  type    = map(string)
}

variable "region" {
  default     = ""
  description = "If not set, the provider's current region will be used."
  type        = string
}

variable "short_name" {
  type = string
}

variable "vpc_cidr" {
  type = string
}
