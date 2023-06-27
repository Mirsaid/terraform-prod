resource "aws_instance" "ec2_instance" {
  ami                    = var.ami_id
  iam_instance_profile   = aws_iam_instance_profile.ec2_profile.name
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [var.ec2_sg_id]
  availability_zone      = var.availability_zone
  subnet_id              = var.private_subnet_1a_ec2_id


    user_data = <<-EOF
              #!/bin/bash
              sudo apt-get update -y
              sudo apt-get install -y nfs-common
              sudo mkdir /mnt/efs
              sudo echo "${var.efs_dns_name}:/ /mnt/efs nfs4 nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,_netdev 0 0" >> /etc/fstab
              sudo mount -a
              EOF


  #Add a root EBS volume
    root_block_device {
    delete_on_termination = false
    volume_size = 15
    volume_type = "gp3"
    #root_device_name = "/dev/sda1" 
    #encrypted = true
    tags = {
      Name = "EC2 Root Volume"
      Backup  = "true"
    }
  }
    tags = {
    Name = "EC2 Instance"
    Role    = "ec2"
    
  }
}


#EC@ instance for tetsing purpose: only comment out when needed
# resource "aws_instance" "ec2_instance_2" {
#   ami                    = var.ami_id
#   instance_type          = var.instance_type
#   key_name               = var.key_name
#   vpc_security_group_ids = [var.ec2_sg_id]
#   availability_zone      = var.availability_zone
#   subnet_id              = var.private_subnet_1a_ec2_id
#   tags = {
#     Name = "Server"
#   }

#     user_data = <<-EOF
#               #!/bin/bash
#               sudo apt-get update -y
#               sudo apt-get install -y nfs-common
#               sudo mkdir /mnt/efs
#               sudo echo "${var.efs_dns_name}:/ /mnt/efs nfs4 nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,_netdev 0 0" >> /etc/fstab
#               sudo mount -a
#               EOF


#   #Add a root EBS volume
#     root_block_device {
#     delete_on_termination = true
#     volume_size = 15
#     tags = {
#       Name = "EC2 Root Volume"
#     }
#   }
# }

