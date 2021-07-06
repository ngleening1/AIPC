terraform {
    required_version = ">= 1.0.0"
    required_providers {
        docker = {
            source  = "kreuzwerker/docker"
            version = "2.13.0"
        }
        local = {
            source  = "hashicorp/local"
            version = "2.1.0"
        }
        digitalocean = {
            source  = "digitalocean/digitalocean"
            version = "2.10.1"
        }
    }
}

provider "docker" {
    host      = var.docker_host
    cert_path = var.docker_cert_path
}

provider "local" {}

provider digitalocean {
    token = var.DO_token
}