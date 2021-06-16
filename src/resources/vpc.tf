resource "aws_vpc" "this" {
  cidr_block = var.cidr_block_vpc

  tags = merge(local.common_tags, {
    Name = "VPC ${local.env}"
  })
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id
  tags = merge(local.common_tags, {
    Name = "IG ${local.env}"
  })
}

resource "aws_subnet" "this" {
  for_each = {
    "pub_a" = ["192.168.1.0/24", "${lookup(var.aws_region, local.env)}a", "Public A - ${local.env}"]
    "pub_b" = ["192.168.2.0/24", "${lookup(var.aws_region, local.env)}b", "Public B - ${local.env}"]
    "pvt_a" = ["192.168.3.0/24", "${lookup(var.aws_region, local.env)}a", "Private A - ${local.env}"]
    "pvt_b" = ["192.168.4.0/24", "${lookup(var.aws_region, local.env)}b", "Private B - ${local.env}"]
  }

  vpc_id            = aws_vpc.this.id
  cidr_block        = each.value[0]
  availability_zone = each.value[1]

  tags = merge(local.common_tags, { Name = each.value[2] })
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }

  tags = merge(local.common_tags, { Name = "Terraform Public - ${local.env}" })
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.this.id

  tags = merge(local.common_tags, { Name = "Terraform Private - ${local.env}" })
}

resource "aws_route_table_association" "this" {
  for_each  = local.subnet_ids
  subnet_id = each.value

  route_table_id = substr(each.key, 0, 3) == "Pub" ? aws_route_table.public.id : aws_route_table.private.id
}