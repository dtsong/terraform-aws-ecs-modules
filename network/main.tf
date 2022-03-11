resource "aws_vpc" "main" {
  name = var.name
  cidr_block = var.cidr_block

  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
}

resource "aws_eip" "nat_gateway" {
  vpc = true
}

resource "aws_nat_gateway" "main" {
  allocation_id = aws_eip.nat_gateway.id
  subnet_id     = aws_subnet.public.id
}

data "aws_availability_zones" "available" {
  status = "available"
}

// BEGIN Public Subnet
resource "aws_subnet" "public" {
  availability_zone       = data.aws_availability_zones.available.names[0]
  cidr_block              = var.public_subnet_cidr_block
  map_public_ip_on_launch = var.map_public_ip_on_launch
  vpc_id                  = aws_vpc.main.id
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }
}

resource "aws_route" "public_internet_gateway" {
  route_table_id         = aws_route_table.public[0].id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.this[0].id
}

resource "aws_route_table_association" "public" {
  route_table_id = aws_route_table.public.id
  subnet_id      = aws_subnet.public.id
}

resource "aws_network_acl" "public" {
  subnet_ids = [aws_subnet.public.id]
  vpc_id     = aws_vpc.main.id
}
// END Public Subnet

// BEGIN Private Subnet
resource "aws_subnet" "private" {
  availability_zone       = data.aws_availability_zones.available.names[0]
  cidr_block              = var.private_subnet_cidr_block
  vpc_id                  = aws_vpc.main.id
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id
}

resource "aws_route_table_association" "private" {
  route_table_id = aws_route_table.private.id
  subnet_id      = aws_subnet.private.id
}

resource "aws_network_acl" "private" {
  subnet_ids = [aws_subnet.private.id]
  vpc_id     = aws_vpc.main.id
}
// END Private Subnet

resource "aws_security_group" "main" {
  name   = var.security_group_name
  vpc_id = aws_vpc.main.id

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"

    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"

    cidr_blocks = ["0.0.0.0/0"]
  }
}