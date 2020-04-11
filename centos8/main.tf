provider "libvirt" {
  uri = "qemu:///system"
}

resource "libvirt_volume" "centos-8-qcow2" {
  name   = "centos-8.qcow2"
  pool   = "images"
  source = "/var/lib/libvirt/images/centos8.qcow2"
  format = "qcow2"
}

resource "libvirt_domain" "centos" {
  name   = "centos8"
  memory = "4096"
  vcpu   = 2

  network_interface {
    network_name = "default"
  }

  disk {
    volume_id = libvirt_volume.centos-8-qcow2.id
  }

  console {
    type        = "pty"
    target_type = "serial"
    target_port = "0"
  }
}

# Print the IP
# Can use `virsh domifaddr <vm_name> <interface>` to get the ip later
