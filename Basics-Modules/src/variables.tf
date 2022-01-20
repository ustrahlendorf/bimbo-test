variable "instance_name" {
  description = "Value of the Name tag for the EC2 instance"
  type        = string
  default     = "TF-ExampleInstance"
}
variable "appServer_instance_type" {
  description = "type for the EC2 instance"
  type        = string
  default     = "t2.micro"
}
variable "ami_amznLinux2" {
  description = "Amazon Linux 2 AMI (HVM) - Kernel 5.10, SSD Volume Type; eu-central-1"
  type        = string
  default     = "ami-05cafdf7c9f772ad2"
}
