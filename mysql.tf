resource "aws_db_instance" "altoze_mysqldb" {
    allocated_storage = 20
    engine = "mysql"
    instance_class = "db.t2.micro"
    db_name = "altozedb"
    username = var.altozedbusername
    password = var.altozedbpassword
    port = 3306
    vpc_security_group_ids = [ aws_security_group.altoze_db_sg.id ]
    db_subnet_group_name = aws_db_subnet_group.altoze_prisubnet_group.name
    multi_az = true
}
resource "aws_db_subnet_group" "altoze_prisubnet_group" {
    name = "altoze-private-sng"
    subnet_ids = [ aws_subnet.altoze_prisubnet1.id, aws_subnet.altoze_prisubnet2.id ]
}
resource "aws_security_group" "altoze_db_sg" {
    name = "altoze-db-sg"
    vpc_id = aws_vpc.altoze_vpc.id
    ingress {
        to_port = 3306
        protocol = "tcp"
        cidr_blocks = ["10.1.0.0/16"]
        from_port = 3306
    }
    egress {
        from_port        = 0
        to_port          = 0
        protocol         = "-1"
        cidr_blocks      = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
    }
}