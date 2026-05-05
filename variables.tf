variable "aws_instance_type" {
  default = "t3.micro"
  type = string
}

variable "aws_default_root_storage_size" {
  default = 15
  type = number
}

variable "ec2_ami_id" {
    default= "ami-07062e2a343acc423"
  type = string
}

variable "env" {
  default = "dev"   #prod for production
  type = string
  
}
