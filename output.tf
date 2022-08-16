output "ec2publicip" {
  description = "public ip"
#   count = length(aws_instance.altoze_apache_instance)
# count = length(aws_instance.altoze_apache_instance)
  value = [for a in aws_instance.altoze_apache_instance : a.public_ip]
#   .public_ip
#   .public_ip
}
output "elburl" {
  description = "elastic load balance public url"
  value = aws_lb.altoze_apache_lb.dns_name
}
output "dburl"{
  description = "db url endpoint"
  value = aws_db_instance.altoze_mysqldb.endpoint
}