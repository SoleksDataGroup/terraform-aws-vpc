// Module name: VPC
// Provider name: AWS
//

variable "name" {
  description = "Name of VPC"
  type = string
  default  = "generic"
}

variable "cidr_block" {
  description  = "CIDR block associated with VPC"
  type = string
  default         = "10.0.0.0/16"
}

variable "region" {
  description     = "VPC deployment region"
  type            = string
  default         = "us-west-2"
}

variable "azs" {
  description = "VPC deployment availability zones"
  type = list(string)
  default  = ["a"]
}
