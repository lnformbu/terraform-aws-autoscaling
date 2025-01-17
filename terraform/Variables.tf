variable "region" {
  type    = string
  default = "us-east-1"
}

# variable "vpc_id" {
#   type    = string
#   default = "" 
# }

# variable "subnet_ids" {
#   type    = list(string)
#   default = [] 
# }

variable "ami_id" {
  type    = string
  default = "ami-0c02fb55956c7d316"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "min_size" {
  type    = number
  default = 2
}

variable "max_size" {
  type    = number
  default = 5
}

variable "bucket_name" {
  type    = string
  default = "luit-terraform-proj2-backend"
}

variable "key_name" {
  type    = string
  default = "test"
}