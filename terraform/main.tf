resource "google_compute_instance" "app_server" {
  name         = "bootsoft-vm-v2"
  machine_type = "e2-micro"
  zone         = "asia-northeast1-b"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-13"
    }
  }

  network_interface {
    network = "default"
    access_config {
      # Leaving this empty creates an Ephemeral IP
    }
  }

  metadata_startup_script = file("${path.module}/setup.sh")

  tags = ["http-server", "https-server"]
}

output "instance_ip" {
  value = google_compute_instance.app_server.network_interface.0.access_config.0.nat_ip
}