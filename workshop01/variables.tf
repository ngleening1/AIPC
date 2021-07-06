variable docker_host {
    type = string
}

variable docker_cert_path {
    type = string
}

variable DO_token {
    type        = string
    description = "Token for Digital Ocean"
    sensitive   = true
}

variable dov_version {
    type        = string
    description = "Image tag default to v4"
    default     = "v4"
}

variable dov_instances {
    type    = list(string)
    default = ["one", "two", "three"]
}

variable public_key {
    type = string
}

variable private_key {
    type      = string
    sensitive = true
}

variable image {
    type = string
}

variable region {
    type = string
}

variable size {
    type = string
}
