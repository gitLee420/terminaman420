provider "aws" {
  region     = "ap-southeast-1"
  access_key = "AKIAWPNXBAGRE7UUO67R"
  secret_key = "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"
}

resource "aws_vpc" "prod-vpc" {
  cidr_block = "192.168.0.0/16"
  tags = {
    Name = "lee420vpctest"
  }
}
resource "aws_internet_gateway" "gw" {
  vpc_id = "lee420vpctest"


}

resource "aws_route_table" "public-route-table" {
 vpc_id = "lee420vpctest"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  route {
    ipv6_cidr_block = "::/0"
    gateway_id      = aws_internet_gateway.gw.id
 }

  tags = {
    Name = "Public-rtb"
   }
}

#Associate subnet with Route Table
resource "aws_route_table_association" "public-route-table" {
 subnet_id      = "public-subnet-420"
 route_table_id = aws_route_table.public-route-table.id
}

resource "aws_route_table" "prod-route-table" {
 vpc_id = aws_vpc.prod-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  route {
    ipv6_cidr_block = "::/0"
    gateway_id      = aws_internet_gateway.gw.id
 }

  tags = {
    Name = "Prod"
   }
}



resource "aws_subnet" "subnet-1" {
vpc_id            = aws_vpc.prod-vpc.id
 cidr_block        = "192.168.0.0/18"
  availability_zone = "ap-southeast-1a"

 tags = {
    Name = "public-subnet-420"
   }
}



resource "aws_subnet" "subnet-2" {
vpc_id            = aws_vpc.prod-vpc.id
 cidr_block        = "192.168.64.0/18"
  availability_zone = "ap-southeast-1b"

 tags = {
    Name = "private-subnet-420"
   }
}

resource "aws_subnet" "subnet-3" {
vpc_id            = aws_vpc.prod-vpc.id
 cidr_block        = "192.168.128.0/18"
  availability_zone = "ap-southeast-1c"

 tags = {
    Name = "reserved1-subnet-420"
   }
}

resource "aws_subnet" "subnet-4" {
vpc_id            = aws_vpc.prod-vpc.id
 cidr_block        = "192.168.192.0/18"
  availability_zone = "ap-southeast-1a"

 tags = {
    Name = "reserved2-subnet-420"
   }
}



