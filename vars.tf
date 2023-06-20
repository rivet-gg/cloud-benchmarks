variable "linode_token" {
	type = string
	sensitive = true
}

variable "test_suite" {
    type = list(object({
        provider = string
        size = string
        region = string
    }))
}

