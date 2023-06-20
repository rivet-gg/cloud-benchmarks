resource "null_resource" "setup" {
    for_each = local.test_suite_map

	depends_on = [module.server]

    triggers = {
        script = md5(file("${path.module}/remote_scripts/setup.sh"))
    }

	connection {
		type = "ssh"
		host = module.server[each.key].host
		user = module.server[each.key].user
		private_key = module.server[each.key].private_key_openssh
	}

	provisioner "remote-exec" {
        script = "${path.module}/remote_scripts/setup.sh"
	}
}

