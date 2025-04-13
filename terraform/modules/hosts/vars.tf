variable "asg" {
  type = object({
    capacity                    = string
    max_instance_count_per_zone = number
    max_zones                   = number
    min_instance_count_per_zone = number
  })
}

variable "tenant_name" {
  type = string
}
