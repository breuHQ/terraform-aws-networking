/**
 * Double Virtual Private Cloud
 **/

resource aws_vpc default {
  cidr_block           = var.cidr_block
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    name        = "${var.name}-${var.environment}"
    environment = var.environment
    # Reserved tags for naming resources
    Name = "${var.name}-${var.environment}"
  }
}

/**
 * Public Subnets
 **/

data aws_availability_zones available {
  state = "available"
}


resource aws_subnet public {
  count                   = length(var.public_subnets)
  vpc_id                  = aws_vpc.default.id
  cidr_block              = element(var.public_subnets, count.index)
  availability_zone       = element(data.aws_availability_zones.available.names, count.index + length(var.public_subnets))
  map_public_ip_on_launch = true

  tags = {
    name        = "${var.name}-public-${var.environment}"
    environment = var.environment
    # Reserved tags for naming resources
    Name = "${var.name}-public-${var.environment}"
  }
}

/**
 * Private Subnets
 **/

resource aws_subnet private {
  count             = length(var.private_subnets)
  vpc_id            = aws_vpc.default.id
  cidr_block        = element(var.private_subnets, count.index)
  availability_zone = element(data.aws_availability_zones.available.names, count.index)

  tags = {
    name        = "${var.name}-private-${var.environment}"
    environment = var.environment

    # Reserved tags for naming resources
    Name = "${var.name}-private-${var.environment}"
  }

}

/**
 * Gateways
 **/

resource aws_internet_gateway default {
  vpc_id = aws_vpc.default.id

  tags = {
    name        = "${var.name}-${var.environment}-gateway"
    environment = var.environment
  }
}

/**
 * Routes
 **/

resource aws_route_table default {
  vpc_id = aws_vpc.default.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.default.id
  }

  tags = {
    Name        = "${var.name}-${var.environment}-route"
    environment = var.environment

  }
}

resource aws_route_table_association public {
  subnet_id      = element(sort(aws_subnet.public.*.id), 0)
  route_table_id = aws_route_table.default.id
}

resource aws_route_table_association private {
  subnet_id      = element(sort(aws_subnet.private.*.id), 1)
  route_table_id = aws_route_table.default.id
}
