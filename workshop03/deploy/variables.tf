variable droplet_region {
    type = string
    default = "sgp1"
}

variable DO_token {
    type = string
    description = "this is DO token"
    sensitive = true
}

variable droplet_size {
    type = string
    default = "s-1vcpu-1gb"
}

variable cs_version {
    type = string
    default = "3.10.2"
}

variable private_key {
    type = string
    sensitive = true
    default = "../../../.ssh/fred"
}

variable cs_password {
    type = string
    sensitive = true
    default = "changeit"
}