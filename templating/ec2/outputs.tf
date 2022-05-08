output "userdata" {
  value = aws_instance.web.user_data
}

output "endpoint" {
  value = "${aws_instance.web.public_ip}:8080"
}
