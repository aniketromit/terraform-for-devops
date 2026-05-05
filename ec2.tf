#Key Pair (login)
resource aws_key_pair my_key {
    key_name = "terra-key-ec2"
    public_key = file("terra-key-ec2.pub")
    
  
}

#vpc & secuirity group

resource "aws_default_vpc" "default" {
  
}

resource aws_security_group my_security_group {
    name = "automate-sg"
    description = "this will add an tf generated security group"
    vpc_id = aws_default_vpc.default.id #interpolation (wayy to inherit the value from aws block)

    #inbound rules
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "SSH Open"
        
    }
    ingress {
        
        from_port = 80
        to_port = 80
        protocol ="tcp"
        cidr_blocks =  ["0.0.0.0/0"]
        description = "HTTP Open"
        
    }

    ingress {
        from_port = 8000
        to_port = 8000
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "Flask app"
    }
    #outbound rules
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1" #simantically equivalent for all protocols
        cidr_blocks = ["0.0.0.0/0"]
        description = "all access open outbound"
    }
    tags = {
      Name ="automate-sg"
    }
}

#ec2_instance

resource "aws_instance" "myterrainstance" {
    #count = 2
    for_each = tomap({
        Aniket_ec2_from_tws_micro = "t3.micro"
        Aniket_ec2_from_tws_small = "t3.small"
        Aniket_ec2_from_tws_large = "t3.small"
    })

    depends_on = [ aws_security_group.my_security_group,aws_key_pair.my_key ]
    key_name = aws_key_pair.my_key.key_name
    security_groups = [aws_security_group.my_security_group.name]
    #instance_type = var.aws_instance_type
    instance_type = each.value
    ami = var.ec2_ami_id #ubuntu

    user_data = file("install_nginx.sh") #running shell script from C:\Users\Arijit\terraform-for-devops\install_nginx.sh
    user_data_replace_on_change = true
    
    root_block_device {
        volume_size = var.env== "prod" ? 20 : var.aws_default_root_storage_size
        volume_type = "gp3"
    }
    
    
    tags = {
        #Name = "Anikets-instance-terra-aws"
        Name = each.key
    }

    
}

resource "aws_instance" "my_imp_instance" {
    ami = "ami-0fe18bc3cfa53a248"
    instance_type = "t3.micro"
}