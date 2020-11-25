variable "name" {
  default     = "leomenezessz-bucket"
  description = "Default bucket name"
}

variable "acl" {
  default     = "private"
  description = "Default acl"
}

variable "key" {
  default     = ""
  description = "Default path for local file to upload for s3"
}

variable "source_file" {
  default     = ""
  description = "Default destiny for file in s3"
}

variable "create_object" {
  default     = false
  description = "Default value to create object in bucket or not"
}

variable "versioning" {
  default     = false
  description = "Default value to bucket versioning"
}

