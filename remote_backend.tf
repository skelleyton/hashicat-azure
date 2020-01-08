terraform {
  backend "remote" {
    hostname = "app.terraform.io"
    organization = "dkelley"
    workspaces {
      name = "hashicat-azure"
    }
  }
}