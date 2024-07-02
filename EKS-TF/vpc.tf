data "aws_vpc" "vpc" {
  filter {
    name   = "tag:Name"
    values = ["jenkins-vpccc"]
  }
}

data "aws_internet_gateway" "igw" {
  filter {
    name   = "tag:Name"
    values = ["jenkins-igwww"]
  }
}

data "aws_subnet" "subnet" {
  filter {
    name   = "tag:Name"
    values = ["jenkins-subnettt"]
  }
}

data "aws_security_group" "sg-default" {
  filter {
    name   = "tag:Name"
    values = ["jenkins-sggg"]
  }
}

resource "aws_subnet" "public-subnet2" {
  vpc_id                  = data.aws_vpc.vpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "ap-northeast-2a"
  map_public_ip_on_launch = true

  tags = {
    Name = "Jenkins-subnet2"
  }
}

resource "aws_route_table" "rt2" {
  vpc_id = data.aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = data.aws_internet_gateway.igw.id
  }

  tags = {
    Name = "Jjenkins-route-table2"
  }
}

resource "aws_route_table_association" "rt-association2" {
  route_table_id = aws_route_table.rt2.id
  subnet_id      = aws_subnet.public-subnet2.id
}
