#Variable for AZ
variable "availability_zone" {
    type = string
    default = "us-east-1b"
}
variable "instance_type" {
    type    = string
    default = "t2.micro"
}

# EC2 SSH Login Key name
variable "key_name" {
  type = string
  default = "chit_test"
  description = "Key name of the Key Pair to use for the instance"
}
# EC2 root disk vars
variable "EC2_ROOT_VOLUME_SIZE" {
  type    = string
  default = "30"
  description = "The volume size for the root volume in GiB"
}
variable "EC2_ROOT_VOLUME_TYPE" {
  type    = string
  default = "gp2"
  description = "The type of data storage: standard, gp2, io1"
}
variable "EC2_ROOT_VOLUME_DELETE_ON_TERMINATION" {
  default = true
  description = "Delete the root volume on instance termination."
}
variable "EC2_ROOT_VOLUME_ENCRYPT" {
  default = true
  description = "Encrypt the root disk"
}

# EC2 data disk vars
variable "EC2_DATA_DEVICE_NAME" {
  type    = string
  default = "/dev/xvda"
  description = "The volume size for the root volume in GiB"
}

variable "EC2_DATA_VOLUME_SIZE" {
  type    = string
  default = "30"
  description = "The volume size for the root volume in GiB"
}
variable "EC2_DATA_VOLUME_TYPE" {
  type    = string
  default = "gp2"
  description = "The type of data storage: standard, gp2, io1"
}
variable "EC2_DATA_VOLUME_ENCRYPT" {
  default = true
  description = "Encrypt the data disk"
}
variable "EC2_DATA_VOLUME_DELETE_ON_TERMINATION" {
  default = true
  description = "Delete the root volume on instance termination."
}

# EC2 Networking vars
variable "subnet_id" {
    type    = string
    default = "subnet-0065c9ae2b16bbc77"
    description = "Subnet ID"

}
variable "associate_public_ip_address" {
    default = true
    description = "assign public IP"

}
variable "security_groups_id" {
  type    = list(string)
  default = ["sg-0789430be393234db","sg-0d5d6ea9492f61d0f"]
}

# List of Tags for resources
variable "default_tags" {
  default     = {
 
     Environment = "Test"
     Owner       = "TFProviders"
     Project     = "Test"
 
}
  description = "Default Tags for Auto Scaling Group"
  type        = map(string)
}

