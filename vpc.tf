resource "aws_vpc" "altoze_vpc" {
  cidr_block = "10.1.0.0/16"
}
resource "aws_subnet" "altoze_pubsubnet1"{
    vpc_id = aws_vpc.altoze_vpc.id
    cidr_block = "10.1.1.0/24"
    availability_zone = "us-east-1a"
}
resource "aws_subnet" "altoze_pubsubnet2"{
    vpc_id = aws_vpc.altoze_vpc.id
    cidr_block = "10.1.2.0/24"
    availability_zone = "us-east-1b"
}
resource "aws_subnet" "altoze_prisubnet1" {
    vpc_id = aws_vpc.altoze_vpc.id
    cidr_block = "10.1.3.0/24"
    availability_zone = "us-east-1a"
}
resource "aws_subnet" "altoze_prisubnet2" {
    vpc_id = aws_vpc.altoze_vpc.id
    cidr_block = "10.1.4.0/24"
    availability_zone = "us-east-1b"
}
resource "aws_internet_gateway" "altoze_igw"{
    vpc_id = aws_vpc.altoze_vpc.id
}
resource "aws_route_table" "altoze_pubsubnet1_routetable"{
    vpc_id = aws_vpc.altoze_vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.altoze_igw.id
    }
}
resource "aws_route_table_association" "altoze_pubsubnet1_routetable_association" {
  subnet_id = aws_subnet.altoze_pubsubnet1.id
  route_table_id = aws_route_table.altoze_pubsubnet1_routetable.id
}

resource "aws_route_table" "altoze_pubsubnet2_routetable"{
    vpc_id = aws_vpc.altoze_vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.altoze_igw.id
    }
}
resource "aws_route_table_association" "altoze_pubsubnet2_routetable_association" {
  subnet_id = aws_subnet.altoze_pubsubnet2.id
  route_table_id = aws_route_table.altoze_pubsubnet2_routetable.id
}