output "web1" {
  description = "ID of the EC2 instance"
  value       = aws_instance.web1.id
}

output "aws_instance_public_dns" {
  description = "Public A record of the EC2 instance"
  value       = aws_instance.web1.public_dns
}

output "aws_instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.web1.public_ip
}

output "aws_ami_amzn2" {
  description = "Amazon Linux2 AMI"
  value       = data.aws_ami.latest-amzn2.id
}

output "aws_ami_al2023" {
  description = "Amazon Linux 2023 AMI"
  value       = data.aws_ami.al2023-ami.id
}
