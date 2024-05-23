resource "aws_vpc" "vpc" {
  cidr_block = var.cidr_block

  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Name = var.name 
  }
}

resource "aws_internet_gateway" "vpc-igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.name}-igw"  
  }
}

resource "aws_subnet" "vpc-private-subnet" {
  vpc_id = aws_vpc.vpc.id
  count = "${length(var.azs)}"

  cidr_block = "${cidrsubnet(var.cidr_block, 2, count.index)}"
  availability_zone = "${var.region}${element(var.azs, count.index)}"

  tags = {
    Name = "${var.name}-private-subnet-${element(var.azs, count.index)}"
  }
}

resource "aws_subnet" "vpc-public-subnet" {
  vpc_id = aws_vpc.vpc.id
  count = "${length(var.azs)}"

  cidr_block = "${cidrsubnet(var.cidr_block, 2, count.index+length(var.azs))}"
  availability_zone = "${var.region}${element(var.azs,count.index)}"

  tags = {
    Name = "${var.name}-public-subnet-${element(var.azs,count.index)}"
  }
}

resource "aws_eip" "vpc-natgw-eip" {
  count = "${length(var.azs)}"
  vpc = true
}

resource "aws_nat_gateway" "vpc-natgw" {
  count = "${length(var.azs)}"
  
  allocation_id = aws_eip.vpc-natgw-eip[count.index].id
  subnet_id = aws_subnet.vpc-public-subnet[count.index].id

  depends_on = [aws_internet_gateway.vpc-igw]
}

resource "aws_route_table" "vpc-rt" {
  count = "${length(var.azs)}"

  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.vpc-natgw[count.index].id
  }
}

resource "aws_route_table_association" "vpc-rt-assoc" {
  count = "${length(var.azs)}"
  
  subnet_id = aws_subnet.vpc-private-subnet[count.index].id
  route_table_id = aws_route_table.vpc-rt[count.index].id
}

resource "aws_default_route_table" "vpc-defaul-route-table" {
  default_route_table_id = aws_vpc.vpc.default_route_table_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.vpc-igw.id
  }

  tags = {
    Name = "${var.name}-default-route-table"
  }
}
