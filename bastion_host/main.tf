resource "aws_instance" "bastion" {
  ami           = "ami-01a2825a801771f57" # Ubuntu 22.04 LTS AMI ID
  instance_type = "t2.micro"
  subnet_id     = var.public_subnet_1a_id
  key_name      = var.key_name
  availability_zone = var.availability_zone
  tags = {
    Name = "bastion"
  }

  vpc_security_group_ids = [var.bastion_sg_id]
    # user_data = <<-EOF
    #           #!/bin/bash
    #           sudo apt update -y
    #           sudo apt-get install -y python3-pip
    #           sudo pip3 install ansible
    #           EOF

    root_block_device {
    delete_on_termination = true
    volume_size = 10
    tags = {
        Name = "Bastion Root Volume"
    }
  }



    #############################################################################
  # This is the 'remote exec' method.
  # Ansible runs on the target host.
  #############################################################################

  provisioner "remote-exec" {
    inline = [
      "mkdir /home/${var.ssh_user}/ansible"
    ]
      
      connection {
      type        = "ssh"
      user        = var.ssh_user
      host        = aws_instance.bastion.public_ip
      private_key = file("${var.private_key_path}")
    }

  }

    provisioner "file" {
    source = "./ansible/inventory.ini"

    # source      = "modules/vpc/ansible/matlab.yml"
      destination = "/home/${var.ssh_user}/ansible/inventory.ini"
      connection {
      type        = "ssh"
      user        = var.ssh_user
      host        = aws_instance.bastion.public_ip
      private_key = file("${var.private_key_path}")
    }
  }
      provisioner "file" {
    source = "./ansible/install_matlab_java.yml"

    # source      = "modules/vpc/ansible/matlab.yml"
    destination = "/home/${var.ssh_user}/ansible/install_matlab_java.yml"
      connection {
      type        = "ssh"
      user        = var.ssh_user
      host        = aws_instance.bastion.public_ip
      private_key = file("${var.private_key_path}")
    }
  }
}

# resource "null_resource" "install_ansible" {

#   provisioner "remote-exec" {
#     inline = [
#       "export DEBIAN_FRONTEND=noninteractive", 
#       # "set -x",
#       "sudo sleep 10s",
#       "sudo apt update -y",
#       "sudo apt-get install -y python3-pip",
#       "sudo pip3 install ansible",
#       "sleep 30s",
#       "cd /home/${var.ssh_user}/ansible",
#       "yes | sudo ansible-playbook -i inventory.ini install_matlab_java.yml",
#       "sudo sleep 30s"
#     ]
#       connection {
#       type        = "ssh"
#       user        = var.ssh_user
#       host        = aws_instance.bastion.public_ip
#       private_key = file("${var.private_key_path}")
#     }
#   }
# }

