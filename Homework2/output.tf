output "aws_instance_public_dns" {
    value = aws_instance.web_server.*.public_dns
}

output "aws_instance_DB_dns" {
    value = aws_instance.DB_server.*.public_dns
}