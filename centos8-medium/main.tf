provider "libvirt" {
  uri = "qemu:///system"
}

resource "libvirt_volume" "centos-medium-qcow2" {
  name   = "centos-medium.qcow2"
  pool   = "images"
  source = "/var/lib/libvirt/images/centos8-medium.qcow2"
  format = "qcow2"
}

resource "libvirt_domain" "centos-medium" {
  name   = "centos-medium"
  memory = "8192"
  vcpu   = 2

  network_interface {
    network_name = "default"
  }

  disk {
    volume_id = libvirt_volume.centos-medium-qcow2.id
  }

  console {
    type        = "pty"
    target_type = "serial"
    target_port = "0"
  }
}

# Print the IP
# Can use `virsh domifaddr <vm_name> <interface>` to get the ip later
