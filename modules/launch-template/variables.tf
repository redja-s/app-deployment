variable "launch_template_name" {
  type = string
}

variable "ami_id" {
  type = string
}

 variable "instance_type" {
  type = string
 }

 variable "security_group_ids" {
  type = list(string)
}

