variable "aws_region" {
  description = "AWS region where the resources will be created"

  type = object({
    dev  = string
    prod = string
  })

  default = {
    dev  = "us-east-1"
    prod = "us-east-2"
  }
}

variable "aws_profile" {
  type    = string
  default = "default"
}

variable "instance" {
  description = "Instance configuration for workspace"

  type = object({
    dev = object({
      ami    = string
      type   = string
      number = number
    })

    prod = object({
      ami    = string
      type   = string
      number = number
    })
  })

  default = {
    dev = {
      ami    = "ami-0d5eff06f840b45e9"
      number = 1
      type   = "t2.micro"
    }
    prod = {
      ami    = "ami-0d5eff06f840b45e9"
      number = 2
      type   = "t2.micro"
    }
  }
}

variable "cidr_block_vpc" {
  type    = string
  default = "192.168.0.0/16"

}