
# resource "tls_private_key" "ssh_key" {
#   algorithm = "RSA"

# }

# data "tls_public_key" "ssh_key" {
#   private_key_pem = tls_private_key.ssh_key.private_key_pem
# }

# resource "aws_key_pair" "generated_key" {
#   key_name   = "generated_key"
#   public_key = data.tls_public_key.ssh_key.public_key_openssh
# }
# # provisioner "local-exec" {
# #   command = "echo '${tls_private_key.ssh_key.private_key_pem}' > private_key.pem"
# # }