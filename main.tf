resource "aws_vpc" "default" {
  tags       = merge(var.tags, { Name = "BrainboardVPC" })
  cidr_block = var.vpc_cidr
}

resource "aws_route_table_association" "aws_route_table_association_11" {
  subnet_id      = aws_subnet.private_a.id
  route_table_id = aws_route_table.rt_private_a.id
}

resource "aws_route_table_association" "aws_route_table_association_12" {
  subnet_id      = aws_subnet.private_b.id
  route_table_id = aws_route_table.rt_private_b.id
}

resource "aws_route_table_association" "aws_route_table_association_13" {
  subnet_id      = aws_subnet.private_c.id
  route_table_id = aws_route_table.rt_private_c.id
}

