#Output for count
# output "ec2_public_ip" {
#   value = aws_instance.myterrainstance[*].public_ip
# }

# output "ec2_public_dns" {
#     value = aws_instance.myterrainstance[*].public_dns
  
# }

# output "ec2_private_ip" {
#   value = aws_instance.myterrainstance[*].private_ip
# }

#Output for each
 output "ec2_private_ip" {
   value = [
    for instance in aws_instance.myterrainstance : instance.private_ip
   ]
 }

output "environment" {
  value       = var.env
  description = "The current deployment environment"
}

# output "storage" {
#   value = {
#     for key, instance in aws_instance.myterrainstance : key => instance.root_block_device[0].volume_size
#   }
#   description = "Volume size for each instance"
# }