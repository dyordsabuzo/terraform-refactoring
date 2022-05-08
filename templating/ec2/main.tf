resource "aws_instance" "web" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = "t3.micro"
  associate_public_ip_address = true
  iam_instance_profile        = aws_iam_instance_profile.profile.id
  vpc_security_group_ids      = [aws_security_group.web_sg.id]
  user_data = base64encode(
    templatefile("${path.module}/templates/instance_init_config.tpl", {
      host_port      = 8080,
      container_port = 80,
      container_name = "nginx",
      image          = "nginx:latest"
    })
  )
}

resource "aws_iam_instance_profile" "profile" {
  name = "ec2-templating-profile"
  role = aws_iam_role.role.name
}

resource "aws_iam_role" "role" {
  name                = "ec2-templating-role"
  assume_role_policy  = data.aws_iam_policy_document.assume_policy.json
  managed_policy_arns = ["arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"]
}

resource "aws_security_group" "web_sg" {
  name        = "ec2-templating-sg"
  description = "Allow traffic flow"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "web-proxy-access"
  }
}
