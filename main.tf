resource "azurerm_resource_group" "myresourcegroup" {
  name     = "${var.prefix}-workshop"
  location = var.location
}


# We're using a little trick here so we can run the provisioner without
# destroying the VM. Do not do this in production.

# If you need ongoing management (Day N) of your virtual machines a tool such
# as Chef or Puppet is a better choice. These tools track the state of
# individual files and can keep them in the correct configuration.

# Here we do the following steps:
# Sync everything in files/ to the remote VM.
# Set up some environment variables for our script.
# Add execute permissions to our scripts.
# Run the deploy_app.sh script.

  module "web_app_container" {
  source              = "app.terraform.io/dkelley/web-app-container/azurerm"
  name                = "${var.prefix}"
  port                = "80"
  https_only          = "false"
  resource_group_name = "${azurerm_resource_group.myresourcegroup.name}"
  container_type      = "docker"
  container_image     = "scarolan/palacearcade"
  plan = {
    sku_size = "B1"
    name     = "${var.prefix}-plan"
  }
}
  output "container_app_url" {
    value = "http://${module.web_app_container.hostname}"
}
}
