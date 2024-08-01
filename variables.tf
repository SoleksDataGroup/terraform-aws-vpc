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

variable "routes" {
  description = "VPC routes to external resources"
  type = list(object({

// One of the following destination arguments must be supplied:
    cidr_block = optional(string)
    ipv6_cidr_block = optional(string)
    destination_prefix_list_id = optional(string)

// One of the following target arguments must be supplied:
    carrier_gateway_id = optional(string)
    core_netwlr_arn = optional(string)
    egress_only_gateway_id = optional(string)
    gateway_id = optional(string)
    local_gateway_id = optional(string)
    nat_gateway_id = optional(string)
    network_interface_id = optional(string)
    transit_gateway_id = optional(string)
    vpc_endpoint_id = optional(string)
    vpc_peering_connection_id = optional(string)
  }))
  default = []
}
