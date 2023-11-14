provider "aws" {
  access_key = ""
  secret_key = ""
  region     = "us-east-1"

}

resource "aws_vpc" "app_vpc" {
  cidr_block = "172.28.0.0/16"
}

resource "aws_subnet" "public_a" {
  vpc_id            = aws_vpc.app_vpc.id
  cidr_block        = "172.28.0.0/19"
  availability_zone = "us-east-1a"

  tags = {
    "Name" = "dp9_public | us-east-1a-k8"
  }
}

resource "aws_subnet" "private_a" {
  vpc_id            = aws_vpc.app_vpc.id
  cidr_block        = "172.28.32.0/19"
  availability_zone = "us-east-1a"


  tags = {
    "Name" = "dp9_private | us-east-1a-k8"
  }
}

resource "aws_subnet" "public_b" {
  vpc_id            = aws_vpc.app_vpc.id
  cidr_block        = "172.28.64.0/19"
  availability_zone = "us-east-1b"

  tags = {
    "Name" = "dp9_public | us-east-1b-k8"
  }
}

resource "aws_subnet" "private_b" {
  vpc_id            = aws_vpc.app_vpc.id
  cidr_block        = "172.28.96.0/19"
  availability_zone = "us-east-1b"

  tags = {
    "Name" = "dp9_private | us-east-1b-k8"
  }
}

resource "aws_route_table_association" "public_a_subnet" {
  subnet_id      = aws_subnet.public_a.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private_a_subnet" {
  subnet_id      = aws_subnet.private_a.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "public_b_subnet" {
  subnet_id      = aws_subnet.public_b.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private_b_subnet" {
  subnet_id      = aws_subnet.private_b.id
  route_table_id = aws_route_table.private.id
}

resource "aws_eip" "elastic-ip" {
  domain = "vpc"
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.app_vpc.id
}

resource "aws_nat_gateway" "ngw" {
  subnet_id     = aws_subnet.public_a.id
  allocation_id = aws_eip.elastic-ip.id
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.app_vpc.id
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.app_vpc.id
}

resource "aws_route" "public_igw" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route" "private_ngw" {
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.ngw.id
}

resource "aws_security_group" "http" {
  name        = "httpalb"
  description = "HTTP ALB traffic"
  vpc_id      = aws_vpc.app_vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "ingress_app" {
  name        = "ingress-app"
  description = "Allow ingress to APP"
  vpc_id      = aws_vpc.app_vpc.id

  ingress {
    from_port   = 8000
    to_port     = 8000
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

   ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
