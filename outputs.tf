output "vpc_id" {
  description = "VPC ID"
  value = aws_vpc.vpc.id
}

output "public_subnet_ids" {
  description = "VPC Public subnets IDs"
  value = aws_subnet.vpc-public-subnet[*].id
}

output "public_subnets_cidrs" {
  description = "VPC public subnets CIDRs"
  value = aws_subnet.vpc-public-subnet[*].cidr_block
}

output "private_subnet_ids" {
  description = "VPC private subnets IDs"
  value = aws_subnet.vpc-private-subnet[*].id 
}

output "private_subnets_cidrs" {
  description = "VPC private subnets CIDRs"
  value = aws_subnet.vpc-private-subnet[*].cidr_block
}
