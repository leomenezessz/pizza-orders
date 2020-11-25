variable "ami" {
  default     = "ami-04bf6dcdc9ab498ca"
  description = "Default ami"
}

variable "instance_type" {
  default     = "t2.micro"
  description = "Default ec2 instance"
}

variable "tags" {
  type        = "map"
  description = "Default ec2 tags"

  default = {
    "Name" = "MyBeatifulEC2"
  }
}
