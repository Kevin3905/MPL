/*resource "local_file" "pet_name" {

  filename = "${path.module}/pet-name.txt"
content  = "My pet is not called Kesiha!!"

 
}

resource "random_pet" "other-pet" {
  length = 1
  prefix = "Mr"
  separator = "."
}*/



resource "local_file" "my-pet" {
  filename = "${path.module}/${var.filename}"
  content  = "My pet is not called Kesiha!!"
}

resource "random_pet" "other-pet" {
  prefix    = var.prefix
  separator = var.separator
  length    = var.length
}

######## local_files - server_role & server_region ########
######## In a file named main.tf, create resources using the variables defined above: #######
######## Create a local_file resource named server_role_file that uses the ######
######## first item in the server_roles list to generate a file. The file ######
######## should be named server-role-[FIRST_ROLE].txt and contain the text ######
######## "The first server role is [FIRST_ROLE]", where [FIRST_ROLE] is  ######
######## replaced with the actual role.                                  ########

######## Create another local_file resource named server_region_file that ######
######## statically references an item in the server_regions set (after ######
######## converting it to a list with tolist) to generate a file. The file ######
######## should be named server-region.txt and contain the text "The server ######
######## region is [ANY_REGION]", where [ANY_REGION] is replaced with the #######
######## actual region. Note: Since sets are unordered, the item might vary. #######


resource "local_file" "server_role_file" {
  filename = "${path.module}/server-role-${var.server_roles[0]}.txt"
  content  = "The first server role is ${var.server_roles[0]}"
}

resource "local_file" "server_region_file" {
  filename = "${path.module}/server-region.txt"
  content  = "The server region is ${tolist(var.server_regions)[2]}"
}

#############################################################################

##### Map Variables ##### 
##### Maps have 1 variable type ##### 


variable "app_settings" {
  description = "Configuration settings for the application."
  type        = map(string)
  default     = {

    "environment" = "production"
    "debug_mode"  = "false"
    "version"     = "1.0.0"

  }

}

##### Map-Resource #####

resource "local_file" "app_config" {
  filename = "${path.module}/app-config.txt"
  content  = "Environment setting: ${var.app_settings["environment"]}"
}

resource "local_file" "app_config_files" {

  for_each = var.app_settings
  filename = "${path.module}/${each.key}-config.txt"
  content  = "${each.key}: ${each.value}"

}

#### Map Resource #####

 resource "local_file" "server_info" {
      filename = "${path.module}/server-config-summary.txt"

      content = <<-EOT
          Hostname: ${var.server_config.hostname}
          IP Address: ${var.server_config.ip_address}
          Operating System: ${var.server_config.operating_system}
          Active: ${var.server_config.is_active ? 'Yes' : 'No'}
          Installed Services: ${join(", ", var.server_config.installed_services)}
          EOT

}

#############################################################
####Movtivated Mindstates Outputs ####

output "server_config_summary" {

  description = "Summary of server configuration."
  value = <<-EOT
    Hostname: ${var.server_config.hostname}
    IP Address: ${var.server_config.ip_address}
    Operating System: ${var.server_config.operating_system}\
    Active: ${var.server_config.is_active ? "Yes" : "No"}
    Installed Services: ${join(", ", var.server_config.installed_services)}
  EOT

}

##################################################################

#### Variable Objects #####
###  Objects can have multiple variable types ####

variable "server_config" {

  description = "Configuration settings for a server."

  type = object({
    hostname          = string
    ip_address        = string
    operating_system  = string
    is_active         = bool
    installed_services = list(string)

  })

  default = {
    hostname          = "server01"
    ip_address        = "192.168.1.10"
    operating_system  = "Ubuntu"
    is_active         = true
    installed_services = ["nginx", "mysql"]

  } 

  }




##########################################################
#### Tuples - Variable ####
#### String - Number - Bool#### 

variable "kitty" {
  dedescription = "value"
  type     = tuple([ string, number, bool ])
  default  = []
}

#### Tuple Resource #####

resource "local_file" "node_info" {

  filename = "${path.module}/node-config-summary.txt"

  content = <<-EOT
  Node Name: ${var.node_config[0]}
  CPU Cores: ${var.node_config[1]}
  Master Node: ${var.node_config[2] ? “Yes” : “No”}
  Role: ${var.node_config[3]}
  EOT

  }

  ##### Count.Index #####

