# main.tf

resource "aws_vpc" "amorserv_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "amorserv_vpc"
  }
}

resource "aws_subnet" "amorserv_public_subnet_1" {
  vpc_id            = aws_vpc.amorserv_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-west-2a" # Specify your desired availability zone
  tags = {
    Name = "amorserv_public_subnet_1"
  }
}

resource "aws_subnet" "amorserv_private_subnet_1" {
  vpc_id            = aws_vpc.amorserv_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-west-2a" # Specify your desired availability zone
  tags = {
    Name = "amorserv_private_subnet_1"
  }
}


resource "aws_subnet" "amorserv_public_subnet_2" {
  vpc_id            = aws_vpc.amorserv_vpc.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "us-west-2b" # Specify your desired availability zone
  tags = {
    Name = "amorserv_public_subnet_2"
  }
}

resource "aws_subnet" "amorserv_private_subnet_2" {
  vpc_id            = aws_vpc.amorserv_vpc.id
  cidr_block        = "10.0.4.0/24"
  availability_zone = "us-west-2b" # Specify your desired availability zone
  tags = {
    Name = "amorserv_private_subnet_2"
  }
}
