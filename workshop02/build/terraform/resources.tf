data digitalocean_ssh_key mykey {
    name = "fred"
}

// create a droplet, ubuntu 20.04.x64, sgp1, s-1vcpu-1gb
// set the corresponding private key the above public key
// output the ipv4 address of the droplet
resource digitalocean_droplet nginx {
    name = "nginx"
    image = var.droplet_image
    size = var.droplet_size
    region = var.droplet_region

    ssh_keys = [ "eb:c8:74:90:65:56:8d:28:7d:53:73:e7:e2:b8:17:fb" ]

}

// local variables, not available outside of this 'module'
output nginx_ipv4 {
    value = digitalocean_droplet.nginx.ipv4_address
}

