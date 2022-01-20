output "vpc_id" {
  description = "ID of the Vpc"
  value       = module.vpc.vpc_id
}

output "default_sg_id" {
  description = "ID of the default SG in the Vpc"
  value       = module.vpc.default_security_group_id
}

output "webServer_sg_id" {
  description = "ID of the WebServer-SG"
  value       = module.web_server_sg.security_group_id
}

output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.app_server.id
}

output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.app_server.public_ip
}