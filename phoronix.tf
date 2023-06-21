resource "null_resource" "phoronix" {
    for_each = local.test_suite_map

	depends_on = [null_resource.setup, null_resource.sysbench]

    triggers = {
        script = md5(file("${path.module}/remote_scripts/phoronix.sh"))
    }

	connection {
		type = "ssh"
		host = module.server[each.key].host
		user = module.server[each.key].user
		private_key = module.server[each.key].private_key_openssh
	}

	provisioner "remote-exec" {
        script = "${path.module}/remote_scripts/phoronix.sh"
	}
}

