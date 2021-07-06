#docker resources
resource docker_image img_dov {
    name = "chukmunnlee/dov-bear:${var.dov_version}"
}

resource docker_container cont_dov {
    count = length(var.dov_instances)
    name  = "dov-${count.index}"
    image = docker_image.img_dov.latest
    env   = [
        "INSTANCE_NAME=dov-bear-${var.dov_instances[count.index]}"
    ]

    ports {
        internal = 3000
    }
}


#digitalocean resources
resource digitalocean_ssh_key default-key {
    name       = "default"
    public_key = file(var.public_key)
}

resource digitalocean_droplet reverse-proxy {
    name     = "reverse-proxy"
    image    = var.image
    region   = var.region
    size     = var.size
    ssh_keys = [digitalocean_ssh_key.default-key.fingerprint]

    connection {
        type        = "ssh"
        user        = "root"
        private_key = file(var.private_key)
        host        = self.ipv4_address
    }

    provisioner "remote-exec" {
        inline = [ # no user intervention allowed
            "apt update - y",
            "apt upgrade - y",
            "apt install nginx - y",
            "systemctl start nginx",
            "systemctl enable nginx"
        ]
    }


    # /usr/sbin/nginx -s reload
}


#local variables
locals {
    ext_ports = [for c in docker_container.cont_dov: "${c.ports[0].external}/${c.ports[0].protocol}"]
}


#generate artefacts
resource local_file external_ports{
    filename = "external_ports.txt"
    content  = templatefile("./external_ports.txt.tpl", {
        ports = [for c in docker_container.cont_dov: "${c.ports[0].external}/${c.ports[0].protocol}"]
        }
    )
}


#outputs
output image_name {
    description = "Container name"
    value       = docker_container.cont_dov[*].name
}

output all_ports {
    description = "Ports"
    value       = docker_container.cont_dov[*].ports
}

output external_ports {
    value = "${docker_container.cont_dov[*].ports[0].external}"
}

output external_ports_v2 {
    value = local.ext_ports #as defined in locals above
}

output ipv4 {
    value = digitalocean_droplet.reverse-proxy.ipv4_address
}