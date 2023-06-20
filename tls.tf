resource "tls_private_key" "main" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_sensitive_file" "tmp_private_key" {
    filename = "${path.module}/tmp/key.pem"
    content = tls_private_key.main.private_key_pem
    file_permission = "600"
}
