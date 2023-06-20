terraform {
	required_providers {
		linode = {
			source  = "linode/linode"
		}
	}
}

provider "linode" {
	token = var.linode_token
}

locals {
    test_suite_map = {
        for i, v in var.test_suite:
        "${v.provider}:${v.size}:${v.region}" => merge(v, {
            index = i
            local_path = "${path.module}/bench-output/${v.provider}/${v.size}/${v.region}"
        })
    }
}


module "server" {
    source = "github.com/rivet-gg/terraform-generic-server?ref=ac58a690ae5afac1af495d43cf4b92946131e500"

    for_each  = local.test_suite_map

	namespace = "cloudbench"
	private_key_openssh = tls_private_key.main.private_key_openssh

	region = {
		provider = each.value.provider
		provider_region = each.value.region
		netnum = 0
		supports_vlan = false
	}

	size = each.value.size
	label = "cloudbench-${each.value.index}"
	tags = ["cloudbench"]

	firewall_inbound = []
}

resource "null_resource" "copy_outputs" {
    for_each = local.test_suite_map

    depends_on = [
        null_resource.geekbench,
        null_resource.ookla_speedtest,
    ]

    triggers = {
        geekbench = null_resource.geekbench[each.key].id
        ookla_speedtest = null_resource.ookla_speedtest[each.key].id
        taint = 1
    }

    provisioner "local-exec" {
        command = "rm -rf '${each.value.local_path}' && mkdir -p '${each.value.local_path}' && scp -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -r -i ${local_sensitive_file.tmp_private_key.filename} root@${module.server[each.key].host}:/root/bench-output '${each.value.local_path}'"
    }
}

