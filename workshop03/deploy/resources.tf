locals {
    cs_image = "code-server-${var.cs_version}"
}

data digitalocean_ssh_key fred {
    name = "fred"
}

data digitalocean_image code-server-image {
    name = local.cs_image
}

// create a droplet, ubuntu 20.04.x64, sgp1, s-1vcpu-1gb
// set the corresponding private key the above public key
// output the ipv4 address of the droplet
resource digitalocean_droplet code-server {
    name = local.cs_image
    image = data.digitalocean_image.code-server-image.id
    size = var.droplet_size
    region = var.droplet_region

    ssh_keys = [ data.digitalocean_ssh_key.fred.id ]
}

resource local_file inventory_yaml {
    filename = "inventory.yaml"
    content = templatefile("./inventory.yaml.tpl", {
        ipv4_address = digitalocean_droplet.code-server.ipv4_address,
        private_key = var.private_key,
        cs_password = var.cs_password,
        cs_domain = "code-${digitalocean_droplet.code-server.ipv4_address}.nip.io"
    })
}

// local variables, not available outside of this 'module'
output cs_domain {
    value = "code-${digitalocean_droplet.code-server.ipv4_address}.nip.io"
}