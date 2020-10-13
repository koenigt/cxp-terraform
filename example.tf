terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 2.70"
    }
  }
}

provider "aws" {
  profile = "msgcxp"
  region  = "us-east-2"
}

resource "aws_vpc" "cn-vpc" {
  cidr_block       = "10.100.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "ChuckNorrisVPC"
  }
}

resource "aws_subnet" "cn-sb-pub-01" {
  vpc_id     = aws_vpc.cn-vpc.id
  cidr_block = "10.100.1.0/24"
  availability_zone = "us-east-2a"

  tags = {
    Name = "ChuckNorris-Pub-Sub-01"
  }
}

resource "aws_subnet" "cn-sb-pub-02" {
  vpc_id     = aws_vpc.cn-vpc.id
  cidr_block = "10.100.2.0/24"
  availability_zone = "us-east-2b"

  tags = {
    Name = "ChuckNorris-Pub-Sub-02"
  }
}

resource "aws_subnet" "cn-sb-pub-03" {
  vpc_id     = aws_vpc.cn-vpc.id
  cidr_block = "10.100.3.0/24"
  availability_zone = "us-east-2c"

  tags = {
    Name = "ChuckNorris-Pub-Sub-03"
  }
}

resource "aws_subnet" "cn-sb-prv-01" {
  vpc_id     = aws_vpc.cn-vpc.id
  cidr_block = "10.100.11.0/24"
  availability_zone = "us-east-2a"

  tags = {
    Name = "ChuckNorris-Prv-Sub-01"
  }
}

resource "aws_subnet" "cn-sb-prv-02" {
  vpc_id     = aws_vpc.cn-vpc.id
  cidr_block = "10.100.12.0/24"
  availability_zone = "us-east-2b"

  tags = {
    Name = "ChuckNorris-Prv-Sub-02"
  }
}

resource "aws_subnet" "cn-sb-prv-03" {
  vpc_id     = aws_vpc.cn-vpc.id
  cidr_block = "10.100.13.0/24"
  availability_zone = "us-east-2c"

  tags = {
    Name = "ChuckNorris-Prv-Sub-03"
  }
}

resource "aws_internet_gateway" "cn-igw" {
  vpc_id = aws_vpc.cn-vpc.id

  tags = {
    Name = "ChuckNorrisIGW"
  }
}

resource "aws_instance" "cn1" {
  ami           = "ami-03657b56516ab7912"
  instance_type = "t2.micro"
  depends_on = [aws_internet_gateway.cn-igw]
  tags = {
    Name = "ChuckNorris-01"
  }
}

resource "aws_instance" "cn2" {
  ami           = "ami-03657b56516ab7912"
  instance_type = "t2.micro"
  depends_on = [aws_internet_gateway.cn-igw]
  tags = {
    Name = "ChuckNorris-02"
  }
}