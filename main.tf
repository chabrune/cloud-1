terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean" # shorthand for registry.terraform.io/digitalocean/digitalocean
      version = "~> 2.0"
    }
  }
}

provider "digitalocean" {} # You can set your credentials in the provider block, but it is safer to use the DIGITALOCEAN_ACCESS_TOKEN environment variable to avoid committing sensitive values into source control

# resource "digitalocean_ssh_key" "my_ssh_key" {
#   name       = "my-terraform-key"
#   public_key = file("~/.ssh/tf-digitalocean.pub")
# }

resource "digitalocean_droplet" "cloud-1" { # Together, the resource type and resource name form a unique ID for the resource : digitalocean_droplet.cloud-1
  image     = "ubuntu-20-04-x64"
  name      = "cloud-1"
  region    = "fra1"
  size      = "s-1vcpu-2gb"
  # ssh_keys  = [digitalocean_ssh_key.my_ssh_key.fingerprint]
}

output "ip_address" {
  value = digitalocean_droplet.cloud-1.ipv4_address
  description = "The public IP address of your Droplet application."
}