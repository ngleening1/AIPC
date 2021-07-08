variable droplet_region {
    type = string
    default = "sgp1"
}

variable DO_token {
    type = string
    sensitive = true
    default = "349604785595e31e10c6b2ff68cafde4a6f42bea37c1957dd5148b06f4266233"
}

variable droplet_size {
    type = string
    default = "s-1vcpu-1gb"
}

variable droplet_image {
    type = string
    default = "ubuntu-20-04-x64"
}

variable cs_version {
    type = string
    default = "3.10.2"
}

source digitalocean code-server {
    api_token = var.DO_token
    region = var.droplet_region
    image = var.droplet_image
    size = var.droplet_size
    snapshot_name = "code-server-${var.cs_version}"
    ssh_username = "root"
}

build {
	sources = [ 
		"source.digitalocean.code-server"
	]

	provisioner ansible {
		playbook_file = "./playbook.yaml"
        extra_arguments = [
            "-e", "cs_version=${var.cs_version}"
        ]
	}
}