variable "stage" {}
variable "vpc_cidr" {}

resource "aws_vpc" "vpc" {
  cidr_block                       = var.vpc_cidr
  enable_dns_hostnames             = true
  enable_dns_support               = true
  instance_tenancy                 = "default"
  assign_generated_ipv6_cidr_block = false

  tags = {
    Name = "${var.stage}-vpc"
  }
}

resource "aws_subnet" "subnet_public_1c" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = cidrsubnet(aws_vpc.vpc.cidr_block, 8, 0)
  availability_zone = "ap-northeast-1c"
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.stage}-subnet-public-1c"
  }
}

resource "aws_subnet" "subnet_public_1d" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = cidrsubnet(aws_vpc.vpc.cidr_block, 8, 1)
  availability_zone = "ap-northeast-1d"
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.stage}-subnet-public-1d"
  }
}

resource "aws_subnet" "subnet_private_1c_1" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = cidrsubnet(aws_vpc.vpc.cidr_block, 8, 2)
  availability_zone = "ap-northeast-1c"

  tags = {
    Name = "${var.stage}-subnet-private-1c-1"
  }
}

resource "aws_subnet" "subnet_private_1d_1" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = cidrsubnet(aws_vpc.vpc.cidr_block, 8, 3)
  availability_zone = "ap-northeast-1d"

  tags = {
    Name = "${var.stage}-subnet-private-1d-1"
  }
}

resource "aws_subnet" "subnet_private_1c_2" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = cidrsubnet(aws_vpc.vpc.cidr_block, 8, 4)
  availability_zone = "ap-northeast-1c"

  tags = {
    Name = "${var.stage}-subnet-private-1c-2"
  }
}

resource "aws_subnet" "subnet_private_1d_2" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = cidrsubnet(aws_vpc.vpc.cidr_block, 8, 5)
  availability_zone = "ap-northeast-1d"

  tags = {
    Name = "${var.stage}-subnet-private-1d-2"
  }
}
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${var.stage}-igw"
  }
}

resource "aws_route_table" "rtb_public" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${var.stage}-rtb-public"
  }
}

resource "aws_route_table_association" "rtb_assoc_public_1c" {
  route_table_id = aws_route_table.rtb_public.id
  subnet_id      = aws_subnet.subnet_public_1c.id
}

resource "aws_route_table_association" "rtb_assoc_public_1d" {
  route_table_id = aws_route_table.rtb_public.id
  subnet_id      = aws_subnet.subnet_public_1d.id
}

resource "aws_route" "route_igw" {
  route_table_id         = aws_route_table.rtb_public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
  depends_on             = [aws_route_table.rtb_public]
}

resource "aws_route_table" "rtb_private" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${var.stage}-rtb-private"
  }
}

resource "aws_route_table_association" "rtb_assoc_private_1c_1" {
  route_table_id = aws_route_table.rtb_private.id
  subnet_id      = aws_subnet.subnet_private_1c_1.id
}

resource "aws_route_table_association" "rtb_assoc_private_1d_1" {
  route_table_id = aws_route_table.rtb_private.id
  subnet_id      = aws_subnet.subnet_private_1d_1.id
}

resource "aws_route_table_association" "rtb_assoc_private_1c_2" {
  route_table_id = aws_route_table.rtb_private.id
  subnet_id      = aws_subnet.subnet_private_1c_2.id
}

resource "aws_route_table_association" "rtb_assoc_private_1d_2" {
  route_table_id = aws_route_table.rtb_private.id
  subnet_id      = aws_subnet.subnet_private_1d_2.id
}
output vpc_id {
  value = aws_vpc.vpc.id
}
output cidr {
  value = aws_vpc.vpc.cidr_block
}
output public_subnet_ids {
  value = [aws_subnet.subnet_public_1c.id, aws_subnet.subnet_public_1d.id]
}
output private_subnet_ids {
  value = [aws_subnet.subnet_private_1c_1.id, aws_subnet.subnet_private_1d_1.id]
}
output public_route_table_id {
  value = aws_route_table.rtb_public.id
}
output private_route_table_id {
  value = aws_route_table.rtb_private.id
}