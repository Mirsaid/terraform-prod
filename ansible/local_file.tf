resource "local_file" "ansible_inventory" {
  #depends_on = [aws_instance.example]

  filename = "./ansible/inventory.ini"
  content = <<-EOF
  [webservers]
  ${var.ec2_server_private_ip}

  [webservers:vars]
  ansible_user = ${var.ssh_user}
  ansible_ssh_private_key_file = ${var.private_key_path}
  ansible_python_interpreter=/usr/bin/python3
  EOF
}