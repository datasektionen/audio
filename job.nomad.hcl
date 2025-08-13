job "audio" {
  type = "service"

  group "audio" {
    network {
      port "http" { }
    }

    service {
      name     = "audio"
      port     = "http"
      provider = "nomad"
      tags = [
        "traefik.enable=true",
        "traefik.http.routers.audio.rule=Host(`audio.datasektionen.se`)",
        "traefik.http.routers.audio.tls.certresolver=default",
      ]
    }

    task "audio" {
      driver = "docker"

      config {
        image = var.image_tag
        ports = ["http"]
      }

      template {
        data        = <<ENV
{{ with nomadVar "nomad/jobs/audio" }}
DATABASE_URL=postgresql://audio:{{ .db_password }}@postgres.dsekt.internal:5432/audio
{{ end }}
ROCKET_PORT={{ env "NOMAD_PORT_http" }}
ENV
        destination = "local/.env"
        env         = true
      }

      resources {
        memory = 120
      }
    }
  }
}

variable "image_tag" {
  type = string
  default = "ghcr.io/datasektionen/audio:latest"
}
