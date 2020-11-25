variable "name" {
    default = "leomenezessz-bucket"
    description = "Default bucket name"
}

variable "acl" {
    default = "private"
    description = "Default acl"
}

variable "local_file" {
    default = ""
    description = "Default path for local file to upload for s3"
}

variable "destiny_file" {
    default = ""
    description = "Default destiny for file in s3"
}