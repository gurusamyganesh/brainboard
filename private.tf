resource "aws_route_table" "rt_private_a" {
  vpc_id = aws_vpc.default.id
  tags   = merge(var.tags, { Name = "Brainboad-PvtSubnetRT1" })

  route {
    nat_gateway_id = aws_nat_gateway.nat-gw-2a-public.id
    cidr_block     = var.private_subnets.a
  }
}

resource "aws_route_table" "rt_private_b" {
  vpc_id = aws_vpc.default.id
  tags   = merge(var.tags, { Name = "Brainboad-PvtSubnetRT2" })

  route {
    nat_gateway_id = aws_nat_gateway.nat-gw-2b-public.id
    cidr_block     = var.private_subnets.b
  }
}

resource "aws_route_table" "rt_private_c" {
  vpc_id = aws_vpc.default.id
  tags   = merge(var.tags, { Name = "Brainboad-PvtSubnetRT3" })

  route {
    nat_gateway_id = aws_nat_gateway.nat-gw-2c-public.id
    cidr_block     = var.private_subnets.c
  }
}

resource "aws_subnet" "private_c" {
  vpc_id                  = aws_vpc.default.id
  tags                    = merge(var.tags, { Name = "Brainboad-PVTSubnet3" })
  map_public_ip_on_launch = false
  cidr_block              = var.private_subnets.c
  availability_zone       = "us-east-2c"
}

resource "aws_subnet" "private_b" {
  vpc_id                  = aws_vpc.default.id
  tags                    = merge(var.tags, { Name = "Brainboad-PVTSubnet2" })
  map_public_ip_on_launch = false
  cidr_block              = var.private_subnets.b
  availability_zone       = "us-east-2b"
}

resource "aws_subnet" "private_a" {
  vpc_id                  = aws_vpc.default.id
  tags                    = merge(var.tags, { Name = "Brainboad-PVTSubnet1" })
  map_public_ip_on_launch = false
  cidr_block              = var.private_subnets.a
  availability_zone       = "us-east-2a"
}

