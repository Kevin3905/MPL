variable "filename" {
  description = "The filename for the pet name file"
  type        = string
  default     = "pet-name.txt"

}

variable "content" {
  description = "The content to put in the pet name file"
  type        = string
  default     = "My pet is not called Keisha!!"

}

 
variable "prefix" {
  description = "The prefix for the random pet name"
  type        = string
  default     = "Mr"

}

variable "separator" {
  description = "The separator for the random pet name"
  type        = string
  default     = "."

}

variable "length" {
  description = "The length of the random pet name"
  type        = number
  default     = 1

}

##############################################################
###### In a file named variables.tf, define two variables: ######
###### A list variable named server_roles with the default values of "web", #####
###### "application", "database". ######
###### A set variable named server_regions with the default values of "us-  #####
###### east-1", "us-west-1", "eu-central-1"  ######
###### Ensure each variable includes a description and the correct type. #######

variable "server_roles" {
  description = "List of server roles for infrastructure."
  type        = list(string)
  default     = ["web", "application", "database"]
}

variable "server_regions" {
  description = "Set of server regions, ensuring each region is unique."
  type        = set(string)
  default     = ["us-east-1", "us-west-1", "eu-central-1"]
}