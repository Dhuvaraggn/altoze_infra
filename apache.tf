data "aws_key_pair" "altozekeypair"{
    key_name = "okr-dev-service-keypair"
}
resource "aws_instance" "altoze_apache_instance"{
    count = 2
    associate_public_ip_address = true
    instance_type = "t2.micro"
    ami = "ami-052efd3df9dad4825"
    subnet_id = aws_subnet.altoze_pubsubnet1.id
    security_groups = [
        aws_security_group.altoze_apache_sg.id
    ]
    key_name = data.aws_key_pair.altozekeypair.key_name
    user_data = templatefile("./apachetemplate.sh",
      { 
        "indexfile"= templatefile("./index.php",{"username"= var.altozedbusername, "password"= var.altozedbpassword, "url"=aws_db_instance.altoze_mysqldb.endpoint })
      })
    provisioner "file" {
      source = "./index.php"
      destination = "/etc/www/html/index.php"
      connection {
        type = "ssh"
        user = "root"
        host = self.public_ip
        port = "22"
        private_key = file("~/Downloads/okr-dev-service-keypair.pem")
      }
    }
}
resource "aws_security_group" "altoze_apache_sg"{
    vpc_id = aws_vpc.altoze_vpc.id
    ingress {
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        from_port = 80
    }
    ingress {
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        from_port = 22
    }

    egress {
        from_port        = 0
        to_port          = 0
        protocol         = "-1"
        cidr_blocks      = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
    }
}
# resource "aws_instance" "altoze_apache_instance"{
#     instance_type = "t2.micro"
#     ami = "ami-052efd3df9dad4825"
#     subnet_id = aws_subnet.altoze_prisubnet1.id
#     # user_data = << s
#     # s
#     # EOF 
# }
# data "aws_ami" "ubuntu_image" {
#     filter {
#       name = "name"
#       values = ["Ubuntu Server "]
#     }
#     filter {
#     name = "architecture"
#     values = ["x86"]
#     }

#   filter {
#     name   = "virtualization-type"
#     values = ["hvm"]
#   }
# }

resource "aws_lb" "altoze_apache_lb" {
  name = "altoze-apache-lb"
  load_balancer_type = "application"
  security_groups = [ aws_security_group.altoze_apache_sg.id ]
  subnets = [ aws_subnet.altoze_pubsubnet1.id, aws_subnet.altoze_pubsubnet2.id ]
}
resource "aws_lb_listener" "altoze_lb_listener" {
  load_balancer_arn = aws_lb.altoze_apache_lb.arn
  port = "80"
  protocol = "HTTP"
  default_action {
   type = "forward"
   target_group_arn = aws_lb_target_group.altoze_lb_targetgrp.arn
  }
}
resource "aws_lb_target_group" "altoze_lb_targetgrp" {
  name = "altoze-tg"
  port = 80
  protocol = "HTTP"
  vpc_id = aws_vpc.altoze_vpc.id
}
resource "aws_lb_target_group_attachment" "altoze_tg_attachment" {
  count = 2 
  target_group_arn = aws_lb_target_group.altoze_lb_targetgrp.arn
  target_id = aws_instance.altoze_apache_instance[count.index].id
  port = 80
}